# PowerShell script to save run report to .intent/metrics/ directory
# Usage: save-run-report.ps1 -IntentId <id> [-Status <status>] [-ValidatorPassRate <rate>] [-Retries <count>] [-Score <score>] [-OutputDir <dir>]

param(
    [Parameter(Mandatory=$true)]
    [string]$IntentId,
    
    [ValidateSet("pass", "fail", "repaired")]
    [string]$Status = "pass",
    
    [ValidateRange(0.0, 1.0)]
    [double]$ValidatorPassRate = 1.0,
    
    [int]$Retries = 0,
    
    [ValidateRange(0, 100)]
    [int]$Score = 100,
    
    [string]$OutputDir = ".intent/metrics"
)

try {
    # Create output directory if it doesn't exist
    if (!(Test-Path -Path $OutputDir)) {
        New-Item -ItemType Directory -Path $OutputDir -Force | Out-Null
    }

    # Generate timestamp for filename
    $Timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
    
    # Generate the output filename
    $OutputFile = Join-Path -Path $OutputDir -ChildPath "run_report_${Timestamp}.json"

    # Create the JSON object
    $JsonContent = @{
        intent_id = $IntentId
        status = $Status
        validator_pass_rate = $ValidatorPassRate
        retries = $Retries
        score = $Score
        timestamp = Get-Date -Format "yyyy-MM-ddTHH:mm:ssZ"
    }

    # Convert to JSON and write to file
    $JsonContent | ConvertTo-Json -Depth 10 | Out-File -FilePath $OutputFile -Encoding UTF8

    Write-Output "Run report saved to: $OutputFile"
}
catch {
    Write-Error "Error saving run report: $($_.Exception.Message)"
    exit 1
}