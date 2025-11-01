#!/usr/bin/env bash
# track-metrics.sh - Script to track Intent Kit Reliability Index metrics
set -euo pipefail

# Get the directory of this script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
METRICS_DIR="$PROJECT_ROOT/.intent/metrics"

# Create metrics directory if it doesn't exist
mkdir -p "$METRICS_DIR"

# Get today's date in YYYY-MM-DD format
TODAY=$(date +%Y-%m-%d)

# Metrics file for today
METRICS_FILE="$METRICS_DIR/${TODAY}-metrics.json"

# Initialize or update the metrics file
if [ ! -f "$METRICS_FILE" ]; then
    # Create initial metrics file
    cat > "$METRICS_FILE" << EOF
{
  "date": "$TODAY",
  "runs": 0,
  "successful_first_try": 0,
  "total_retries": 0,
  "total_score": 0,
  "avg_retries": 0,
  "success_rate": 0,
  "avg_score": 0
}
EOF
fi

# Read current metrics
RUNS=$(jq -r '.runs' "$METRICS_FILE")
SUCCESSFUL_FIRST_TRY=$(jq -r '.successful_first_try' "$METRICS_FILE")
TOTAL_RETRIES=$(jq -r '.total_retries' "$METRICS_FILE")
TOTAL_SCORE=$(jq -r '.total_score' "$METRICS_FILE")

# Update metrics based on current run
RUNS=$((RUNS + 1))

if [ "${1:-}" = "success" ]; then
    SUCCESSFUL_FIRST_TRY=$((SUCCESSFUL_FIRST_TRY + 1))
fi

RETRIES=${2:-0}
TOTAL_RETRIES=$((TOTAL_RETRIES + RETRIES))

SCORE=${3:-0}
TOTAL_SCORE=$(echo "$TOTAL_SCORE $SCORE" | awk '{print $1 + $2}')

# Calculate averages
if [ $RUNS -gt 0 ]; then
    AVG_RETRIES=$(echo "$TOTAL_RETRIES $RUNS" | awk '{printf "%.2f", $1/$2}')
    AVG_SCORE=$(echo "$TOTAL_SCORE $RUNS" | awk '{printf "%.2f", $1/$2}')
    SUCCESS_RATE=$(echo "$SUCCESSFUL_FIRST_TRY $RUNS" | awk '{printf "%.2f", ($1/$2)*100}')
else
    AVG_RETRIES=0
    AVG_SCORE=0
    SUCCESS_RATE=0
fi

# Update the metrics file
cat > "$METRICS_FILE" << EOF
{
  "date": "$TODAY",
  "runs": $RUNS,
  "successful_first_try": $SUCCESSFUL_FIRST_TRY,
  "total_retries": $TOTAL_RETRIES,
  "total_score": $TOTAL_SCORE,
  "avg_retries": $AVG_RETRIES,
  "success_rate": $SUCCESS_RATE,
  "avg_score": $AVG_SCORE
}
EOF

# Update the overall reliability index
OVERALL_INDEX_FILE="$METRICS_DIR/reliability-index.json"

# If the overall index file doesn't exist, initialize it
if [ ! -f "$OVERALL_INDEX_FILE" ]; then
    OVERALL_RELIABILITY=$SUCCESS_RATE
    cat > "$OVERALL_INDEX_FILE" << EOF
{
  "latest_date": "$TODAY",
  "latest_success_rate": $SUCCESS_RATE,
  "latest_avg_retries": $AVG_RETRIES,
  "latest_avg_score": $AVG_SCORE,
  "total_runs": $RUNS,
  "total_successful_first_try": $SUCCESSFUL_FIRST_TRY,
  "reliability_score": $OVERALL_RELIABILITY
}
EOF
else
    # Read current overall metrics
    LATEST_DATE=$(jq -r '.latest_date' "$OVERALL_INDEX_FILE")
    TOTAL_RUNS=$(jq -r '.total_runs' "$OVERALL_INDEX_FILE")
    TOTAL_SUCCESSFUL=$(jq -r '.total_successful_first_try' "$OVERALL_INDEX_FILE")
    
    # Calculate new totals
    TOTAL_RUNS=$((TOTAL_RUNS + 1))
    if [ "${1:-}" = "success" ]; then
        TOTAL_SUCCESSFUL=$((TOTAL_SUCCESSFUL + 1))
    fi
    
    # Calculate overall reliability score
    if [ $TOTAL_RUNS -gt 0 ]; then
        OVERALL_RELIABILITY=$(echo "$TOTAL_SUCCESSFUL $TOTAL_RUNS" | awk '{printf "%.2f", ($1/$2)*100}')
    else
        OVERALL_RELIABILITY=0
    fi
    
    # Update the overall index file
    cat > "$OVERALL_INDEX_FILE" << EOF
{
  "latest_date": "$TODAY",
  "latest_success_rate": $SUCCESS_RATE,
  "latest_avg_retries": $AVG_RETRIES,
  "latest_avg_score": $AVG_SCORE,
  "total_runs": $TOTAL_RUNS,
  "total_successful_first_try": $TOTAL_SUCCESSFUL,
  "reliability_score": $OVERALL_RELIABILITY
}
EOF
fi

echo "Metrics updated for $TODAY:"
echo "  Runs: $RUNS"
echo "  Success Rate: $SUCCESS_RATE%"
echo "  Avg Retries: $AVG_RETRIES"
echo "  Avg Score: $AVG_SCORE"
echo "  Reliability Index: $OVERALL_RELIABILITY%"