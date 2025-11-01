# adaptive-learning.ps1 - Script to analyze metrics and adjust agent behavior based on patterns
param()

# Get the directory of this script
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ProjectRoot = Join-Path $ScriptDir "..\.."
$MetricsDir = Join-Path $ProjectRoot ".intent\metrics"

# Create a learning context file to store learned patterns
$LearningContext = Join-Path $ProjectRoot ".intent\learning-context.json"

# Initialize learning context if it doesn't exist
if (!(Test-Path $LearningContext)) {
    $InitialLearningData = @{
        last_analyzed_date = ""
        learned_patterns = @()
        adjustments_applied = 0
        common_failure_modes = @{}
        improvement_strategies = @()
    }
    
    $InitialLearningData | ConvertTo-Json | Out-File -Encoding UTF8 $LearningContext
}

Write-Output "Analyzing metrics for adaptive improvements..."

# Get all metrics files sorted by date
$MetricsFiles = Get-ChildItem -Path $MetricsDir -Name "????-??-??-metrics.json" | Sort-Object

if ($MetricsFiles.Count -eq 0) {
    Write-Output "No metrics files found for analysis."
    exit 0
}

# Calculate trends and patterns
$TotalRuns = 0
$TotalSuccessful = 0
$TotalRetries = 0
$TotalScore = 0
$RunCount = 0

foreach ($File in $MetricsFiles) {
    $FilePath = Join-Path $MetricsDir $File.Name
    $MetricsData = Get-Content $FilePath -Raw | ConvertFrom-Json
    
    $Runs = $MetricsData.runs
    $Successful = $MetricsData.successful_first_try
    $Retries = $MetricsData.total_retries
    $Score = $MetricsData.total_score
    
    $TotalRuns += $Runs
    $TotalSuccessful += $Successful
    $TotalRetries += $Retries
    $TotalScore += $Score
    $RunCount++
}

# Calculate overall averages
if ($TotalRuns -gt 0) {
    $OverallSuccessRate = [math]::Round(($TotalSuccessful / $TotalRuns) * 100, 2)
    $OverallAvgRetries = [math]::Round($TotalRetries / $TotalRuns, 2)
    $OverallAvgScore = [math]::Round($TotalScore / $TotalRuns, 2)
}
else {
    $OverallSuccessRate = 0
    $OverallAvgRetries = 0
    $OverallAvgScore = 0
}

Write-Output "Overall metrics analysis:"
Write-Output "  Total runs: $TotalRuns"
Write-Output "  Success rate: $OverallSuccessRate%"
Write-Output "  Avg retries: $OverallAvgRetries"
Write-Output "  Avg score: $OverallAvgScore"

# Load current learning context
$LearningData = Get-Content $LearningContext -Raw | ConvertFrom-Json
$CurrentDate = Get-Date -Format "yyyy-MM-dd"

# Analyze improvement opportunities
$ImprovementNotes = ""

# Check success rate
if ($OverallSuccessRate -lt 80) {
    $ImprovementNotes += "`n- Low success rate detected ($OverallSuccessRate% < 80%)"
    $ImprovementNotes += "`n- Consider improving initial validation checks"
    $ImprovementNotes += "`n- Focus on more detailed requirement analysis"
    $ImprovementNotes += "`n- Add more comprehensive error checking in generated content"
}

# Check average retries
if ($OverallAvgRetries -gt 1.0) {
    $ImprovementNotes += "`n- High average retries detected ($OverallAvgRetries > 1.0)"
    $ImprovementNotes += "`n- Consider improving initial content quality"
    $ImprovementNotes += "`n- Enhance the generation process with more validation rules"
    $ImprovementNotes += "`n- Add more specific guidance for common failure patterns"
}

# Check average score
if ($OverallAvgScore -lt 7.0) {
    $ImprovementNotes += "`n- Low quality score detected ($OverallAvgScore < 7.0)"
    $ImprovementNotes += "`n- Focus on improving content structure and completeness"
    $ImprovementNotes += "`n- Enhance validation criteria to catch more issues early"
    $ImprovementNotes += "`n- Improve adherence to project standards and requirements"
}

# Update learning context with new analysis
$Adjustments = $LearningData.adjustments_applied
$NewAdjustments = $Adjustments + 1

# Prepare learned patterns based on trends
$LearnedPatterns = $LearningData.learned_patterns

# Add new pattern if we have actionable insights
if ($ImprovementNotes -ne "") {
    # Create a new adaptive strategy based on the analysis
    $UpdatedLearningData = @{
        last_analyzed_date = $CurrentDate
        learned_patterns = $LearnedPatterns
        adjustments_applied = $NewAdjustments
        common_failure_modes = @{
            "low_success_rate" = ($OverallSuccessRate -lt 80)
            "high_retries" = ($OverallAvgRetries -gt 1.0)
            "low_quality_score" = ($OverallAvgScore -lt 7.0)
        }
        improvement_strategies = @()
        current_metrics = @{
            "success_rate" = $OverallSuccessRate
            "avg_retries" = $OverallAvgRetries
            "avg_score" = $OverallAvgScore
            "total_runs" = $TotalRuns
        }
    }
    
    # Add improvement strategies if we have them
    if ($ImprovementNotes -ne "") {
        $UpdatedLearningData.improvement_strategies = @($ImprovementNotes.Trim())
    }
    
    $UpdatedLearningData | ConvertTo-Json -Depth 5 | Out-File -Encoding UTF8 $LearningContext

    Write-Output "Learning applied! Adjustment #$NewAdjustments recorded."
    Write-Output "Improvement notes: $ImprovementNotes"
    
    # Create a context file that the AI agent can reference for improved behavior
    $AdaptiveContext = Join-Path $ProjectRoot ".intent\adaptive-context.md"
    $AdaptiveContent = @"
# Adaptive Learning Context

This file contains learned patterns and improvements based on historical metrics. The AI agent should reference this when generating content.

## Current Performance Metrics
- Success Rate: $OverallSuccessRate%
- Avg Retries: $OverallAvgRetries
- Avg Score: $OverallAvgScore

## Learned Improvement Strategies
$ImprovementNotes

## Recommended Behaviors for Better Outcomes
- Focus on detailed requirement analysis before generation
- Include more comprehensive validation and error handling
- Reference successful patterns from past implementations
- Apply more conservative quality standards initially, then enhance
"@
    
    $AdaptiveContent | Out-File -Encoding UTF8 $AdaptiveContext
    Write-Output "Adaptive context file created at: $AdaptiveContext"
}
else {
    Write-Output "No significant improvement opportunities detected in current metrics."
}

Write-Output "Adaptive learning analysis completed."