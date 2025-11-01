#!/usr/bin/env bash
# adaptive-learning.sh - Script to analyze metrics and adjust agent behavior based on patterns
set -euo pipefail

# Get the directory of this script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
METRICS_DIR="$PROJECT_ROOT/.intent/metrics"

# Create a learning context file to store learned patterns
LEARNING_CONTEXT="$PROJECT_ROOT/.intent/learning-context.json"

# Initialize learning context if it doesn't exist
if [ ! -f "$LEARNING_CONTEXT" ]; then
    cat > "$LEARNING_CONTEXT" << EOF
{
  "last_analyzed_date": "",
  "learned_patterns": [],
  "adjustments_applied": 0,
  "common_failure_modes": {},
  "improvement_strategies": []
}
EOF
fi

echo "Analyzing metrics for adaptive improvements..."

# Get all metrics files sorted by date
METRICS_FILES=$(find "$METRICS_DIR" -name "????-??-??-metrics.json" | sort)

if [ -z "$METRICS_FILES" ]; then
    echo "No metrics files found for analysis."
    exit 0
fi

# Calculate trends and patterns
TOTAL_RUNS=0
TOTAL_SUCCESSFUL=0
TOTAL_RETRIES=0
TOTAL_SCORE=0
RUN_COUNT=0

for file in $METRICS_FILES; do
    RUNS=$(jq -r '.runs' "$file")
    SUCCESSFUL=$(jq -r '.successful_first_try' "$file")
    RETRIES=$(jq -r '.total_retries' "$file")
    SCORE=$(jq -r '.total_score' "$file")
    
    TOTAL_RUNS=$((TOTAL_RUNS + RUNS))
    TOTAL_SUCCESSFUL=$((TOTAL_SUCCESSFUL + SUCCESSFUL))
    TOTAL_RETRIES=$((TOTAL_RETRIES + RETRIES))
    TOTAL_SCORE=$(echo "$TOTAL_SCORE $SCORE" | awk '{print $1 + $2}')
    RUN_COUNT=$((RUN_COUNT + 1))
done

# Calculate overall averages
if [ $TOTAL_RUNS -gt 0 ]; then
    OVERALL_SUCCESS_RATE=$(echo "$TOTAL_SUCCESSFUL $TOTAL_RUNS" | awk '{printf "%.2f", ($1/$2)*100}')
    OVERALL_AVG_RETRIES=$(echo "$TOTAL_RETRIES $TOTAL_RUNS" | awk '{printf "%.2f", $1/$2}')
    OVERALL_AVG_SCORE=$(echo "$TOTAL_SCORE $TOTAL_RUNS" | awk '{printf "%.2f", $1/$2}')
else
    OVERALL_SUCCESS_RATE=0
    OVERALL_AVG_RETRIES=0
    OVERALL_AVG_SCORE=0
fi

echo "Overall metrics analysis:"
echo "  Total runs: $TOTAL_RUNS"
echo "  Success rate: $OVERALL_SUCCESS_RATE%"
echo "  Avg retries: $OVERALL_AVG_RETRIES"
echo "  Avg score: $OVERALL_AVG_SCORE"

# Load current learning context
LEARNING_DATA=$(cat "$LEARNING_CONTEXT")
CURRENT_DATE=$(date +%Y-%m-%d)

# Analyze improvement opportunities
IMPROVEMENT_NOTES=""

# Check success rate
if (( $(echo "$OVERALL_SUCCESS_RATE < 80" | bc -l) )); then
    IMPROVEMENT_NOTES="$IMPROVEMENT_NOTES
- Low success rate detected ($OVERALL_SUCCESS_RATE% < 80%)
- Consider improving initial validation checks
- Focus on more detailed requirement analysis
- Add more comprehensive error checking in generated content"
fi

# Check average retries
if (( $(echo "$OVERALL_AVG_RETRIES > 1.0" | bc -l) )); then
    IMPROVEMENT_NOTES="$IMPROVEMENT_NOTES
- High average retries detected ($OVERALL_AVG_RETRIES > 1.0)
- Consider improving initial content quality
- Enhance the generation process with more validation rules
- Add more specific guidance for common failure patterns"
fi

# Check average score
if (( $(echo "$OVERALL_AVG_SCORE < 7.0" | bc -l) )); then
    IMPROVEMENT_NOTES="$IMPROVEMENT_NOTES
- Low quality score detected ($OVERALL_AVG_SCORE < 7.0)
- Focus on improving content structure and completeness
- Enhance validation criteria to catch more issues early
- Improve adherence to project standards and requirements"
fi

# Update learning context with new analysis
ADJUSTMENTS=$(echo "$LEARNING_DATA" | jq -r '.adjustments_applied')
NEW_ADJUSTMENTS=$((ADJUSTMENTS + 1))

# Prepare learned patterns based on trends
LEARNED_PATTERNS=$(echo "$LEARNING_DATA" | jq '.learned_patterns')

# Add new pattern if we have actionable insights
if [ -n "$IMPROVEMENT_NOTES" ]; then
    # Create a new adaptive strategy based on the analysis
    cat > "$LEARNING_CONTEXT" << EOF
{
  "last_analyzed_date": "$CURRENT_DATE",
  "learned_patterns": $LEARNED_PATTERNS,
  "adjustments_applied": $NEW_ADJUSTMENTS,
  "common_failure_modes": {
    "low_success_rate": $(echo "$OVERALL_SUCCESS_RATE < 80" | bc -l),
    "high_retries": $(echo "$OVERALL_AVG_RETRIES > 1.0" | bc -l),
    "low_quality_score": $(echo "$OVERALL_AVG_SCORE < 7.0" | bc -l)
  },
  "improvement_strategies": [
    $([ -n "$IMPROVEMENT_NOTES" ] && echo "\"$(echo "$IMPROVEMENT_NOTES" | sed 's/"/\\"/g' | tr '\n' ' ' | sed 's/  */ /g' | sed 's/^ *//;s/ *$//')\"")
  ],
  "current_metrics": {
    "success_rate": $OVERALL_SUCCESS_RATE,
    "avg_retries": $OVERALL_AVG_RETRIES,
    "avg_score": $OVERALL_AVG_SCORE,
    "total_runs": $TOTAL_RUNS
  }
}
EOF

    echo "Learning applied! Adjustment #$NEW_ADJUSTMENTS recorded."
    echo "Improvement notes: $IMPROVEMENT_NOTES"
    
    # Create a context file that the AI agent can reference for improved behavior
    ADAPTIVE_CONTEXT="$PROJECT_ROOT/.intent/adaptive-context.md"
    cat > "$ADAPTIVE_CONTEXT" << EOF
# Adaptive Learning Context

This file contains learned patterns and improvements based on historical metrics. The AI agent should reference this when generating content.

## Current Performance Metrics
- Success Rate: $OVERALL_SUCCESS_RATE%
- Avg Retries: $OVERALL_AVG_RETRIES
- Avg Score: $OVERALL_AVG_SCORE

## Learned Improvement Strategies
$(echo "$IMPROVEMENT_NOTES")

## Recommended Behaviors for Better Outcomes
- Focus on detailed requirement analysis before generation
- Include more comprehensive validation and error handling
- Reference successful patterns from past implementations
- Apply more conservative quality standards initially, then enhance
EOF

    echo "Adaptive context file created at: $ADAPTIVE_CONTEXT"
else
    echo "No significant improvement opportunities detected in current metrics."
fi

echo "Adaptive learning analysis completed."