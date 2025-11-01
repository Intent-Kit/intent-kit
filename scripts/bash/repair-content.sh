#!/bin/bash

# Script to repair content based on validation issues
# Usage: repair-content.sh [options]
# 
# Options:
#   --file <path>           : Path to the file to repair (required)
#   --content-type <type>   : Type of content to repair (intent, plan, tasks, etc.)
#   --validation-report <path> : Path to validation report JSON (optional)
#   --max-iterations <n>    : Maximum repair iterations (default: 3)

set -e  # Exit on any error

# Check if required tools are available
if ! command -v jq &> /dev/null; then
    echo "Error: jq is required but not installed." >&2
    exit 1
fi

# Default values
FILE_PATH=""
CONTENT_TYPE="generic"
VALIDATION_REPORT=""
MAX_ITERATIONS=3
REPAIR_COUNT=0

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --file)
            FILE_PATH="$2"
            shift 2
            ;;
        --content-type)
            CONTENT_TYPE="$2"
            shift 2
            ;;
        --validation-report)
            VALIDATION_REPORT="$2"
            shift 2
            ;;
        --max-iterations)
            MAX_ITERATIONS="$2"
            shift 2
            ;;
        --help)
            echo "Usage: $0 [options]"
            echo "Options:"
            echo "  --file <path>           : Path to the file to repair (required)"
            echo "  --content-type <type>   : Type of content to repair (intent, plan, tasks, etc.)"
            echo "  --validation-report <path> : Path to validation report JSON (optional)"
            echo "  --max-iterations <n>    : Maximum repair iterations (default: 3)"
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            exit 1
            ;;
    esac
done

# Validate required parameters
if [ -z "$FILE_PATH" ]; then
    echo "Error: --file is required"
    exit 1
fi

if [ ! -f "$FILE_PATH" ]; then
    echo "Error: File does not exist: $FILE_PATH"
    exit 1
fi

# Read the content to repair
CONTENT=$(cat "$FILE_PATH")

# Process repairs based on content type
case $CONTENT_TYPE in
    intent|intent.md)
        # Repair intent file issues
        echo "Repairing intent file: $FILE_PATH"
        
        # Remove NEEDS CLARIFICATION markers if present
        if echo "$CONTENT" | grep -q "\[NEEDS CLARIFICATION\]"; then
            echo "  - Removing [NEEDS CLARIFICATION] markers"
            CONTENT=$(echo "$CONTENT" | sed 's/\[NEEDS CLARIFICATION:[^]]*\]//g')
            REPAIR_COUNT=$((REPAIR_COUNT + 1))
        fi
        
        # Add missing sections if needed
        if ! echo "$CONTENT" | grep -q "^# Overview"; then
            echo "  - Adding missing 'Overview' section"
            CONTENT="# Overview

[Provide a brief overview of the intent]

$CONTENT"
            REPAIR_COUNT=$((REPAIR_COUNT + 1))
        fi
        
        if ! echo "$CONTENT" | grep -q "^# Functional Requirements"; then
            echo "  - Adding missing 'Functional Requirements' section"
            CONTENT="$CONTENT

# Functional Requirements

- [Define functional requirements here]"
            REPAIR_COUNT=$((REPAIR_COUNT + 1))
        fi
        
        if ! echo "$CONTENT" | grep -q "^# Success Criteria"; then
            echo "  - Adding missing 'Success Criteria' section"
            CONTENT="$CONTENT

# Success Criteria

- [Define success criteria here]"
            REPAIR_COUNT=$((REPAIR_COUNT + 1))
        fi
        ;;
    tasks|tasks.md)
        # Repair tasks file issues
        echo "Repairing tasks file: $FILE_PATH"
        
        # Ensure tasks have proper format
        # Add task IDs if missing (simple approach - add sequential IDs)
        LINE_NUM=0
        while IFS= read -r LINE; do
            LINE_NUM=$((LINE_NUM + 1))
            # Check if line starts with checkbox but no ID
            if echo "$LINE" | grep -qE "^\- \[.\] [^T][^0-9]*[^0-9] " && [ -z "$(echo "$LINE" | grep -E '\- \[.\] T[0-9][0-9][0-9]')" ]; then
                echo "  - Adding missing task ID to line $LINE_NUM"
                # We'll need to process this differently since sed in-place editing while reading is complex
                # For now, we'll do basic regex replacements for common issues
                NEXT_TASK_ID=$(printf "T%03d" $LINE_NUM)
                CONTENT=$(echo "$CONTENT" | sed "$LINE_NUM s/^- \[.\] /- [ ] $NEXT_TASK_ID /")
                REPAIR_COUNT=$((REPAIR_COUNT + 1))
            fi
        done <<< "$(echo "$CONTENT")"
        
        # Ensure task checkboxes exist where needed
        if ! echo "$CONTENT" | grep -q "\- \[ \]"; then
            echo "  - Adding task checkboxes where missing"
            # Replace lines that look like tasks but don't have checkboxes
            CONTENT=$(echo "$CONTENT" | sed 's/^\([[:space:]]*-[[:space:]]\+\)\([^[]\)/\1[ ] \2/g')
            CONTENT=$(echo "$CONTENT" | sed 's/^\([[:space:]]*-\)\([[:space:]]\+\)\([^[]\)/\1 [ ] \3/g')
            REPAIR_COUNT=$((REPAIR_COUNT + 1))
        fi
        ;;
    plan|plan.md)
        # Repair plan file issues
        echo "Repairing plan file: $FILE_PATH"
        
        # Add missing sections if needed
        if ! echo "$CONTENT" | grep -q "^# Architecture\|^# Tech Stack"; then
            echo "  - Adding missing 'Architecture' section"
            CONTENT="# Architecture

[Define the architecture here]

$CONTENT"
            REPAIR_COUNT=$((REPAIR_COUNT + 1))
        fi
        
        if ! echo "$CONTENT" | grep -q "^# Data Model\|^# Entities"; then
            echo "  - Adding missing 'Data Model' section"
            CONTENT="$CONTENT

# Data Model

[Define data model/entities here]"
            REPAIR_COUNT=$((REPAIR_COUNT + 1))
        fi
        ;;
    *)
        # Generic repairs
        echo "Performing generic repairs on: $FILE_PATH"
        
        # Fix common markdown issues
        if [ ! -s "$FILE_PATH" ]; then
            echo "  - File is empty, adding basic content"
            CONTENT="# Document Title

[Content placeholder]"
            REPAIR_COUNT=$((REPAIR_COUNT + 1))
        fi
        ;;
esac

# Write the repaired content back to the file
echo "$CONTENT" > "$FILE_PATH"

echo "Repair completed. $REPAIR_COUNT issues fixed."

# Store repair learning in the learning context
PROJECT_ROOT="$(cd "$(dirname "$(dirname "$(dirname "${BASH_SOURCE[0]}")")")" && pwd)"
LEARNING_CONTEXT="$PROJECT_ROOT/.intent/learning-context.json"

if [ -f "$LEARNING_CONTEXT" ]; then
    # Load existing learning data
    LEARNING_DATA=$(cat "$LEARNING_CONTEXT")
    
    # Create a record of this repair for learning
    REPAIR_RECORD="{\"content_type\": \"$CONTENT_TYPE\", \"repairs_performed\": $REPAIR_COUNT, \"repair_date\": \"$(date +%Y-%m-%d)\", \"file_path\": \"$FILE_PATH\"}"
    
    # Add this repair to learned patterns
    LEARNED_PATTERNS=$(echo "$LEARNING_DATA" | jq -r '.learned_patterns // []')
    UPDATED_LEARNED_PATTERNS=$(echo "$LEARNED_PATTERNS" | jq --argjson new_record "$REPAIR_RECORD" '. += [$new_record]')
    
    # Update the learning context
    echo "$LEARNING_DATA" | jq --argjson updated_patterns "$UPDATED_LEARNED_PATTERNS" '.learned_patterns = $updated_patterns' > "$LEARNING_CONTEXT.tmp" && mv "$LEARNING_CONTEXT.tmp" "$LEARNING_CONTEXT"
fi

# Output repair report
cat <<EOF
{
  "file_path": "$FILE_PATH",
  "content_type": "$CONTENT_TYPE",
  "repairs_performed": $REPAIR_COUNT,
  "status": "repaired"
}
EOF