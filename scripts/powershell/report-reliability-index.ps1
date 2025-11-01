# report-reliability-index.ps1 - Script to generate a report of the Intent Kit Reliability Index
param()

# Get the directory of this script
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ProjectRoot = Join-Path $ScriptDir "..\.."
$MetricsDir = Join-Path $ProjectRoot ".intent\metrics"

# Check if metrics directory exists
if (!(Test-Path $MetricsDir)) {
    Write-Output "No metrics directory found. Run some intent commands first to generate metrics."
    exit 0
}

# Get the overall reliability index
$ReliabilityIndexFile = Join-Path $MetricsDir "reliability-index.json"
if (Test-Path $ReliabilityIndexFile) {
    $ReliabilityIndex = Get-Content $ReliabilityIndexFile -Raw | ConvertFrom-Json
    
    Write-Output "## Intent Kit Reliability Index"
    Write-Output ""
    Write-Output "Overall Reliability Score: $($ReliabilityIndex.reliability_score)%"
    Write-Output "Latest Success Rate: $($ReliabilityIndex.latest_success_rate)%"
    Write-Output "Latest Avg Retries: $($ReliabilityIndex.latest_avg_retries)"
    Write-Output "Latest Avg Score: $($ReliabilityIndex.latest_avg_score)"
    Write-Output "Total Runs: $($ReliabilityIndex.total_runs)"
    Write-Output "Date: $($ReliabilityIndex.latest_date)"
    Write-Output ""
}
else {
    Write-Output "No reliability index found. Run some intent commands first to generate metrics."
    exit 0
}

# Get daily metrics if available
Write-Output "## Daily Metrics"
Write-Output ""

$DailyFiles = Get-ChildItem -Path $MetricsDir -Name "????-??-??-metrics.json" | Sort-Object

if ($DailyFiles.Count -gt 0) {
    foreach ($File in $DailyFiles) {
        $Date = $File.Name -replace "-metrics.json$"
        $FilePath = Join-Path $MetricsDir $File.Name
        $DailyMetrics = Get-Content $FilePath -Raw | ConvertFrom-Json
        
        Write-Output "### $Date"
        Write-Output "Success Rate: $($DailyMetrics.success_rate)%"
        Write-Output "Avg Retries: $($DailyMetrics.avg_retries)"
        Write-Output "Avg Score: $($DailyMetrics.avg_score)"
        Write-Output "Runs: $($DailyMetrics.runs)"
        Write-Output ""
    }
}
else {
    Write-Output "No daily metrics available yet."
}

Write-Output "## Trend Analysis"
Write-Output ""

# Calculate trend if we have multiple days of data
$DailyFilesSorted = Get-ChildItem -Path $MetricsDir -Name "????-??-??-metrics.json" | Sort-Object
if ($DailyFilesSorted.Count -ge 2) {
    # Get first and last dates
    $FirstDate = $DailyFilesSorted[0].Name -replace "-metrics.json$"
    $LastDate = $DailyFilesSorted[-1].Name -replace "-metrics.json$"
    
    Write-Output "Comparing $FirstDate to $LastDate:"
    
    $FirstMetrics = Get-Content (Join-Path $MetricsDir "$FirstDate-metrics.json") -Raw | ConvertFrom-Json
    $LastMetrics = Get-Content (Join-Path $MetricsDir "$LastDate-metrics.json") -Raw | ConvertFrom-Json
    
    $SuccessChange = [math]::Round($LastMetrics.success_rate - $FirstMetrics.success_rate, 2)
    $RetriesChange = [math]::Round($LastMetrics.avg_retries - $FirstMetrics.avg_retries, 2)
    $ScoreChange = [math]::Round($LastMetrics.avg_score - $FirstMetrics.avg_score, 2)
    
    Write-Output "Success Rate Change: $SuccessChange%"
    Write-Output "Avg Retries Change: $RetriesChange"
    Write-Output "Avg Score Change: $ScoreChange"
    
    if ($SuccessChange -gt 0) {
        Write-Output "Overall Improvement: Positive"
    }
    elseif ($SuccessChange -lt 0) {
        Write-Output "Overall Improvement: Negative"
    }
    else {
        Write-Output "Overall Improvement: Neutral"
    }
}
else {
    Write-Output "Insufficient data for trend analysis. Need at least 2 days of metrics."
}