# track-metrics.ps1 - Script to track Intent Kit Reliability Index metrics
param(
    [string]$Status = "run",          # "success" if run passed validation on first try, otherwise "run"
    [int]$Retries = 0,               # Number of retries needed
    [double]$Score = 0.0             # Quality score (0.0 to 10.0)
)

# Get the directory of this script
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ProjectRoot = Join-Path $ScriptDir "..\.."
$MetricsDir = Join-Path $ProjectRoot ".intent\metrics"

# Create metrics directory if it doesn't exist
if (!(Test-Path $MetricsDir)) {
    New-Item -ItemType Directory -Path $MetricsDir -Force
}

# Get today's date in YYYY-MM-DD format
$Today = Get-Date -Format "yyyy-MM-dd"

# Metrics file for today
$MetricsFile = Join-Path $MetricsDir "${Today}-metrics.json"

# Initialize or update the metrics file
if (!(Test-Path $MetricsFile)) {
    # Create initial metrics file
    $InitialMetrics = @{
        date = $Today
        runs = 0
        successful_first_try = 0
        total_retries = 0
        total_score = 0.0
        avg_retries = 0.0
        success_rate = 0.0
        avg_score = 0.0
    }
    
    $InitialMetrics | ConvertTo-Json | Out-File -Encoding UTF8 $MetricsFile
}

# Read current metrics
$CurrentMetrics = Get-Content $MetricsFile -Raw | ConvertFrom-Json

# Update metrics based on current run
$Runs = $CurrentMetrics.runs + 1
$SuccessfulFirstTry = $CurrentMetrics.successful_first_try
if ($Status -eq "success") {
    $SuccessfulFirstTry++
}

$TotalRetries = $CurrentMetrics.total_retries + $Retries
$TotalScore = [math]::Round($CurrentMetrics.total_score + $Score, 2)

# Calculate averages
$AvgRetries = if ($Runs -gt 0) { [math]::Round($TotalRetries / $Runs, 2) } else { 0.0 }
$AvgScore = if ($Runs -gt 0) { [math]::Round($TotalScore / $Runs, 2) } else { 0.0 }
$SuccessRate = if ($Runs -gt 0) { [math]::Round(($SuccessfulFirstTry / $Runs) * 100, 2) } else { 0.0 }

# Update the metrics file
$UpdatedMetrics = @{
    date = $Today
    runs = $Runs
    successful_first_try = $SuccessfulFirstTry
    total_retries = $TotalRetries
    total_score = $TotalScore
    avg_retries = $AvgRetries
    success_rate = $SuccessRate
    avg_score = $AvgScore
}

$UpdatedMetrics | ConvertTo-Json | Out-File -Encoding UTF8 $MetricsFile

# Update the overall reliability index
$OverallIndexFile = Join-Path $MetricsDir "reliability-index.json"

# If the overall index file doesn't exist, initialize it
if (!(Test-Path $OverallIndexFile)) {
    $OverallIndex = @{
        latest_date = $Today
        latest_success_rate = $SuccessRate
        latest_avg_retries = $AvgRetries
        latest_avg_score = $AvgScore
        total_runs = $Runs
        total_successful_first_try = $SuccessfulFirstTry
        reliability_score = $SuccessRate
    }
    
    $OverallIndex | ConvertTo-Json | Out-File -Encoding UTF8 $OverallIndexFile
}
else {
    # Read current overall metrics
    $OverallMetrics = Get-Content $OverallIndexFile -Raw | ConvertFrom-Json
    
    # Calculate new totals
    $TotalRuns = $OverallMetrics.total_runs + 1
    $TotalSuccessful = $OverallMetrics.total_successful_first_try
    if ($Status -eq "success") {
        $TotalSuccessful++
    }
    
    # Calculate overall reliability score
    $OverallReliability = if ($TotalRuns -gt 0) { [math]::Round(($TotalSuccessful / $TotalRuns) * 100, 2) } else { 0.0 }
    
    # Update the overall index file
    $UpdatedOverallIndex = @{
        latest_date = $Today
        latest_success_rate = $SuccessRate
        latest_avg_retries = $AvgRetries
        latest_avg_score = $AvgScore
        total_runs = $TotalRuns
        total_successful_first_try = $TotalSuccessful
        reliability_score = $OverallReliability
    }
    
    $UpdatedOverallIndex | ConvertTo-Json | Out-File -Encoding UTF8 $OverallIndexFile
}

Write-Output "Metrics updated for $Today:"
Write-Output "  Runs: $Runs"
Write-Output "  Success Rate: $SuccessRate%"
Write-Output "  Avg Retries: $AvgRetries"
Write-Output "  Avg Score: $AvgScore"
Write-Output "  Reliability Index: $OverallReliability%"