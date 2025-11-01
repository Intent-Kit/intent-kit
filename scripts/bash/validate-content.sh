#!/bin/bash

# Script to validate generated content quality
# Usage: validate-content.sh [options]
# 
# Options:
#   --file <path>           : Path to the file to validate (required)
#   --content-type <type>   : Type of content to validate (intent, plan, tasks, etc.)
#   --output-json <path>    : Path to save validation report as JSON
#   --config <path>         : Path to validation configuration file

set -e  # Exit on any error

# Default values
FILE_PATH=""
CONTENT_TYPE="generic"
OUTPUT_JSON=""
CONFIG_PATH=""

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
        --output-json)
            OUTPUT_JSON="$2"
            shift 2
            ;;
        --config)
            CONFIG_PATH="$2"
            shift 2
            ;;
        --help)
            echo "Usage: $0 [options]"
            echo "Options:"
            echo "  --file <path>           : Path to the file to validate (required)"
            echo "  --content-type <type>   : Type of content to validate (intent, plan, tasks, etc.)"
            echo "  --output-json <path>    : Path to save validation report as JSON"
            echo "  --config <path>         : Path to validation configuration file"
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

# Get file stats for validation
FILE_SIZE=$(stat -f%z "$FILE_PATH" 2>/dev/null || stat -c%s "$FILE_PATH")
FILE_NAME=$(basename "$FILE_PATH")

# Initialize validation results
VALIDATION_ISSUES=()
PASSED_CHECKS=0
TOTAL_CHECKS=0

# Validate content based on type
case $CONTENT_TYPE in
    intent|intent.md)
        # Check for required sections in intent file
        TOTAL_CHECKS=$((TOTAL_CHECKS + 6))
        
        if grep -q "# Overview" "$FILE_PATH"; then
            PASSED_CHECKS=$((PASSED_CHECKS + 1))
        else
            VALIDATION_ISSUES+=("Missing 'Overview' section")
        fi
        
        if grep -q "# Functional Requirements" "$FILE_PATH"; then
            PASSED_CHECKS=$((PASSED_CHECKS + 1))
        else
            VALIDATION_ISSUES+=("Missing 'Functional Requirements' section")
        fi
        
        if grep -q "# Non-Functional Requirements" "$FILE_PATH"; then
            PASSED_CHECKS=$((PASSED_CHECKS + 1))
        else
            VALIDATION_ISSUES+=("Missing 'Non-Functional Requirements' section")
        fi
        
        if grep -q "# User Scenarios" "$FILE_PATH"; then
            PASSED_CHECKS=$((PASSED_CHECKS + 1))
        else
            VALIDATION_ISSUES+=("Missing 'User Scenarios' section")
        fi
        
        if grep -q "# Success Criteria" "$FILE_PATH"; then
            PASSED_CHECKS=$((PASSED_CHECKS + 1))
        else
            VALIDATION_ISSUES+=("Missing 'Success Criteria' section")
        fi
        
        if grep -q "\[NEEDS CLARIFICATION:" "$FILE_PATH"; then
            VALIDATION_ISSUES+=("Contains [NEEDS CLARIFICATION] markers")
        else
            PASSED_CHECKS=$((PASSED_CHECKS + 1))
        fi
        ;;
    tasks|tasks.md)
        # Check for required task format in tasks file
        TOTAL_CHECKS=$((TOTAL_CHECKS + 5))
        
        if grep -q "\- \[ \]" "$FILE_PATH" || grep -q "\- \[x\]" "$FILE_PATH"; then
            PASSED_CHECKS=$((PASSED_CHECKS + 1))
        else
            VALIDATION_ISSUES+=("Missing task checkboxes (- [ ])")
        fi
        
        if grep -q "T[0-9][0-9][0-9]" "$FILE_PATH"; then
            PASSED_CHECKS=$((PASSED_CHECKS + 1))
        else
            VALIDATION_ISSUES+=("Missing task IDs (T###)")
        fi
        
        if grep -q "src/" "$FILE_PATH" || grep -q "tests/" "$FILE_PATH"; then
            PASSED_CHECKS=$((PASSED_CHECKS + 1))
        else
            VALIDATION_ISSUES+=("Missing file paths in task descriptions")
        fi
        
        if grep -q "US[0-9]" "$FILE_PATH" || grep -q "IS[0-9]" "$FILE_PATH"; then
            PASSED_CHECKS=$((PASSED_CHECKS + 1))
        else
            # Not a critical issue if user stories aren't required
            PASSED_CHECKS=$((PASSED_CHECKS + 1))
        fi
        
        if ! grep -q "\.\.\.P\.\.\." "$FILE_PATH" && grep -q "\[P\]" "$FILE_PATH"; then
            PASSED_CHECKS=$((PASSED_CHECKS + 1))
        else
            # Check for [P] marker format
            if grep -q "\[P\]" "$FILE_PATH"; then
                PASSED_CHECKS=$((PASSED_CHECKS + 1))
            else
                VALIDATION_ISSUES+=("Missing parallel task markers [P] where appropriate")
            fi
        fi
        ;;
    plan|plan.md)
        # Check for required sections in plan file
        TOTAL_CHECKS=$((TOTAL_CHECKS + 4))
        
        if grep -q "# Architecture" "$FILE_PATH" || grep -q "# Tech Stack" "$FILE_PATH"; then
            PASSED_CHECKS=$((PASSED_CHECKS + 1))
        else
            VALIDATION_ISSUES+=("Missing 'Architecture' or 'Tech Stack' section")
        fi
        
        if grep -q "# Data Model" "$FILE_PATH" || grep -q "# Entities" "$FILE_PATH"; then
            PASSED_CHECKS=$((PASSED_CHECKS + 1))
        else
            VALIDATION_ISSUES+=("Missing 'Data Model' or 'Entities' section")
        fi
        
        if grep -q "# Phases" "$FILE_PATH" || grep -q "# Implementation Phases" "$FILE_PATH"; then
            PASSED_CHECKS=$((PASSED_CHECKS + 1))
        else
            VALIDATION_ISSUES+=("Missing 'Phases' section")
        fi
        
        if grep -q "# Quality Gates" "$FILE_PATH" || grep -q "# Validation Criteria" "$FILE_PATH"; then
            PASSED_CHECKS=$((PASSED_CHECKS + 1))
        else
            VALIDATION_ISSUES+=("Missing 'Quality Gates' or 'Validation Criteria' section")
        fi
        ;;
    *)
        # Generic validation for any content
        TOTAL_CHECKS=3
        
        if [ $FILE_SIZE -gt 0 ]; then
            PASSED_CHECKS=$((PASSED_CHECKS + 1))
        else
            VALIDATION_ISSUES+=("File is empty")
        fi
        
        if grep -q "^# " "$FILE_PATH" || grep -q "^## " "$FILE_PATH"; then
            PASSED_CHECKS=$((PASSED_CHECKS + 1))
        else
            VALIDATION_ISSUES+=("Missing markdown headings")
        fi
        
        if grep -q "[a-zA-Z]" "$FILE_PATH"; then
            PASSED_CHECKS=$((PASSED_CHECKS + 1))
        else
            VALIDATION_ISSUES+=("File doesn't contain readable text")
        fi
        ;;
esac

# Calculate pass rate
if [ $TOTAL_CHECKS -gt 0 ]; then
    PASS_RATE=$(echo "scale=2; $PASSED_CHECKS / $TOTAL_CHECKS" | bc)
else
    PASS_RATE=1.0
fi

# Determine validation status
if [ ${#VALIDATION_ISSUES[@]} -eq 0 ]; then
    VALIDATION_STATUS="pass"
else
    VALIDATION_STATUS="fail"
fi

# Create validation report
REPORT_JSON=$(cat <<EOF
{
  "file_path": "$FILE_PATH",
  "file_name": "$FILE_NAME",
  "file_size": $FILE_SIZE,
  "content_type": "$CONTENT_TYPE",
  "validation_status": "$VALIDATION_STATUS",
  "total_checks": $TOTAL_CHECKS,
  "passed_checks": $PASSED_CHECKS,
  "pass_rate": $PASS_RATE,
  "issues": [
EOF
)

# Add issues to report if any exist
if [ ${#VALIDATION_ISSUES[@]} -gt 0 ]; then
    for i in "${!VALIDATION_ISSUES[@]}"; do
        ISSUE=$(echo "${VALIDATION_ISSUES[$i]}" | sed 's/"/\\"/g')  # Escape quotes
        if [ $i -lt $((${#VALIDATION_ISSUES[@]} - 1)) ]; then
            REPORT_JSON+="    \"$ISSUE\",\n"
        else
            REPORT_JSON+="    \"$ISSUE\"\n"
        fi
    done
else
    REPORT_JSON+="    \n"
fi

REPORT_JSON+="  ]\n}"

# Output validation report
echo -e "$REPORT_JSON"

# Save to file if output path specified
if [ ! -z "$OUTPUT_JSON" ]; then
    echo -e "$REPORT_JSON" > "$OUTPUT_JSON"
    echo "Validation report saved to: $OUTPUT_JSON"
fi

# Calculate quality score based on pass rate (0-10 scale)
if [ $TOTAL_CHECKS -gt 0 ]; then
    QUALITY_SCORE=$(echo "scale=2; $PASS_RATE * 10" | bc)
else
    QUALITY_SCORE=10
fi

# Identify specific failure patterns for learning
FAILURE_PATTERNS=""

if [ "$VALIDATION_STATUS" = "fail" ]; then
    # Identify common failure types for learning
    for issue in "${VALIDATION_ISSUES[@]}"; do
        case "$issue" in
            *"Missing 'Overview' section"*)
                FAILURE_PATTERNS="${FAILURE_PATTERNS} missing_intent_overview,"
                ;;
            *"Missing 'Functional Requirements' section"*)
                FAILURE_PATTERNS="${FAILURE_PATTERNS} missing_intent_functional_reqs,"
                ;;
            *"Contains [NEEDS CLARIFICATION] markers"*)
                FAILURE_PATTERNS="${FAILURE_PATTERNS} intent_underspecification,"
                ;;
            *"Missing task checkboxes"* | *"Missing task IDs"*)
                FAILURE_PATTERNS="${FAILURE_PATTERNS} malformed_tasks_format,"
                ;;
            *"Missing file paths in task descriptions"*)
                FAILURE_PATTERNS="${FAILURE_PATTERNS} missing_task_file_paths,"
                ;;
            *"Missing parallel task markers"*)
                FAILURE_PATTERNS="${FAILURE_PATTERNS} missing_parallel_task_markers,"
                ;;
            *"Missing 'Architecture' or 'Tech Stack' section"*)
                FAILURE_PATTERNS="${FAILURE_PATTERNS} missing_plan_architecture,"
                ;;
            *"Missing 'Data Model' or 'Entities' section"*)
                FAILURE_PATTERNS="${FAILURE_PATTERNS} missing_plan_data_model,"
                ;;
            *"File is empty"*)
                FAILURE_PATTERNS="${FAILURE_PATTERNS} empty_file,"
                ;;
            *"Missing markdown headings"*)
                FAILURE_PATTERNS="${FAILURE_PATTERNS} missing_headings_format,"
                ;;
        esac
    done
    
    # Remove trailing comma
    FAILURE_PATTERNS=$(echo "$FAILURE_PATTERNS" | sed 's/,$//')
fi

# Output quality score to stderr so it can be captured separately from JSON
echo "QUALITY_SCORE: $QUALITY_SCORE" >&2

# Output failure patterns if any exist
if [ -n "$FAILURE_PATTERNS" ]; then
    echo "FAILURE_PATTERNS: $FAILURE_PATTERNS" >&2
fi

# Exit with error code if validation failed
if [ "$VALIDATION_STATUS" = "fail" ]; then
    exit 1
fi