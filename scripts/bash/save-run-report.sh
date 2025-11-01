#!/bin/bash

# Script to save run report to .intent/metrics/ directory
# Usage: save-run-report.sh [options]
# 
# Options:
#   --intent-id <id>      : The intent ID (required)
#   --status <status>     : Status (pass|fail|repaired) (default: pass)
#   --validator-pass-rate <rate> : Validator pass rate (0.0-1.0) (default: 1.0)
#   --retries <count>     : Number of retries (default: 0)
#   --score <score>       : Score (0-100) (default: 100)
#   --output-dir <dir>    : Output directory (default: .intent/metrics)

set -e  # Exit on any error

# Default values
INTENT_ID=""
STATUS="pass"
VALIDATOR_PASS_RATE=1.0
RETRIES=0
SCORE=100
OUTPUT_DIR=".intent/metrics"

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --intent-id)
            INTENT_ID="$2"
            shift 2
            ;;
        --status)
            STATUS="$2"
            shift 2
            ;;
        --validator-pass-rate)
            VALIDATOR_PASS_RATE="$2"
            shift 2
            ;;
        --retries)
            RETRIES="$2"
            shift 2
            ;;
        --score)
            SCORE="$2"
            shift 2
            ;;
        --output-dir)
            OUTPUT_DIR="$2"
            shift 2
            ;;
        --help)
            echo "Usage: $0 [options]"
            echo "Options:"
            echo "  --intent-id <id>      : The intent ID (required)"
            echo "  --status <status>     : Status (pass|fail|repaired) (default: pass)"
            echo "  --validator-pass-rate <rate> : Validator pass rate (0.0-1.0) (default: 1.0)"
            echo "  --retries <count>     : Number of retries (default: 0)"
            echo "  --score <score>       : Score (0-100) (default: 100)"
            echo "  --output-dir <dir>    : Output directory (default: .intent/metrics)"
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            exit 1
            ;;
    esac
done

# Validate required parameters
if [ -z "$INTENT_ID" ]; then
    echo "Error: --intent-id is required"
    exit 1
fi

# Create output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# Generate timestamp for filename
TIMESTAMP=$(date -u +"%Y%m%d_%H%M%S")

# Generate the output filename
OUTPUT_FILE="$OUTPUT_DIR/run_report_${TIMESTAMP}.json"

# Create the JSON content
JSON_CONTENT=$(cat <<EOF
{
  "intent_id": "$INTENT_ID",
  "status": "$STATUS",
  "validator_pass_rate": $VALIDATOR_PASS_RATE,
  "retries": $RETRIES,
  "score": $SCORE,
  "timestamp": "$(date -u -Iseconds)"
}
EOF
)

# Write the JSON content to the file
echo "$JSON_CONTENT" > "$OUTPUT_FILE"

echo "Run report saved to: $OUTPUT_FILE"