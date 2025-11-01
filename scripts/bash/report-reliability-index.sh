#!/usr/bin/env bash
# report-reliability-index.sh - Script to generate a report of the Intent Kit Reliability Index
set -euo pipefail

# Get the directory of this script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
METRICS_DIR="$PROJECT_ROOT/.intent/metrics"

# Check if metrics directory exists
if [ ! -d "$METRICS_DIR" ]; then
    echo "No metrics directory found. Run some intent commands first to generate metrics."
    exit 0
fi

# Get the overall reliability index
if [ -f "$METRICS_DIR/reliability-index.json" ]; then
    echo "## Intent Kit Reliability Index"
    echo ""
    echo "Overall Reliability Score: $(jq -r '.reliability_score' "$METRICS_DIR/reliability-index.json")%"
    echo "Latest Success Rate: $(jq -r '.latest_success_rate' "$METRICS_DIR/reliability-index.json")%"
    echo "Latest Avg Retries: $(jq -r '.latest_avg_retries' "$METRICS_DIR/reliability-index.json")"
    echo "Latest Avg Score: $(jq -r '.latest_avg_score' "$METRICS_DIR/reliability-index.json")"
    echo "Total Runs: $(jq -r '.total_runs' "$METRICS_DIR/reliability-index.json")"
    echo "Date: $(jq -r '.latest_date' "$METRICS_DIR/reliability-index.json")"
    echo ""
else
    echo "No reliability index found. Run some intent commands first to generate metrics."
    exit 0
fi

# Get daily metrics if available
echo "## Daily Metrics"
echo ""
DAILY_FILES=$(find "$METRICS_DIR" -name "????-??-??-metrics.json" | sort)
if [ -n "$DAILY_FILES" ]; then
    for file in $DAILY_FILES; do
        DATE=$(basename "$file" -metrics.json | sed 's/-metrics.json$//')
        echo "### $DATE"
        echo "Success Rate: $(jq -r '.success_rate' "$file")%"
        echo "Avg Retries: $(jq -r '.avg_retries' "$file")"
        echo "Avg Score: $(jq -r '.avg_score' "$file")"
        echo "Runs: $(jq -r '.runs' "$file")"
        echo ""
    done
else
    echo "No daily metrics available yet."
fi

echo "## Trend Analysis"
echo ""
# Calculate trend if we have multiple days of data
TREND_FILE=$(mktemp)
find "$METRICS_DIR" -name "????-??-??-metrics.json" -exec basename {} \; | sed 's/-metrics.json$//' | sort > "$TREND_FILE"

LINE_COUNT=$(wc -l < "$TREND_FILE")
if [ "$LINE_COUNT" -ge 2 ]; then
    # Get first and last dates
    FIRST_DATE=$(head -n1 "$TREND_FILE")
    LAST_DATE=$(tail -n1 "$TREND_FILE")
    
    echo "Comparing $FIRST_DATE to $LAST_DATE:"
    
    FIRST_SUCCESS=$(jq -r ".success_rate" "$METRICS_DIR/${FIRST_DATE}-metrics.json")
    LAST_SUCCESS=$(jq -r ".success_rate" "$METRICS_DIR/${LAST_DATE}-metrics.json")
    SUCCESS_CHANGE=$(echo "$LAST_SUCCESS $FIRST_SUCCESS" | awk '{printf "%.2f", $1 - $2}')
    
    FIRST_RETRIES=$(jq -r ".avg_retries" "$METRICS_DIR/${FIRST_DATE}-metrics.json")
    LAST_RETRIES=$(jq -r ".avg_retries" "$METRICS_DIR/${LAST_DATE}-metrics.json")
    RETRIES_CHANGE=$(echo "$LAST_RETRIES $FIRST_RETRIES" | awk '{printf "%.2f", $1 - $2}')
    
    FIRST_SCORE=$(jq -r ".avg_score" "$METRICS_DIR/${FIRST_DATE}-metrics.json")
    LAST_SCORE=$(jq -r ".avg_score" "$METRICS_DIR/${LAST_DATE}-metrics.json")
    SCORE_CHANGE=$(echo "$LAST_SCORE $FIRST_SCORE" | awk '{printf "%.2f", $1 - $2}')
    
    echo "Success Rate Change: $SUCCESS_CHANGE%"
    echo "Avg Retries Change: $RETRIES_CHANGE"
    echo "Avg Score Change: $SCORE_CHANGE"
    
    if (( $(echo "$SUCCESS_CHANGE > 0" | bc -l) )); then
        echo "Overall Improvement: Positive"
    elif (( $(echo "$SUCCESS_CHANGE < 0" | bc -l) )); then
        echo "Overall Improvement: Negative"
    else
        echo "Overall Improvement: Neutral"
    fi
else
    echo "Insufficient data for trend analysis. Need at least 2 days of metrics."
fi

rm -f "$TREND_FILE"