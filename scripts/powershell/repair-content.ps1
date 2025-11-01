# PowerShell script to repair content based on validation issues
# Usage: repair-content.ps1 -FilePath <path> [-ContentType <type>] [-ValidationReport <path>] [-MaxIterations <n>]

param(
    [Parameter(Mandatory=$true)]
    [string]$FilePath,
    
    [string]$ContentType = "generic",
    
    [string]$ValidationReport,
    
    [int]$MaxIterations = 3
)

try {
    # Validate required parameters
    if (!(Test-Path -Path $FilePath)) {
        Write-Error "File does not exist: $FilePath"
        exit 1
    }

    # Read the content to repair
    $Content = Get-Content -Path $FilePath -Raw
    $RepairCount = 0

    # Process repairs based on content type
    switch ($ContentType) {
        {($_ -eq "intent") -or ($_ -eq "intent.md")} {
            Write-Host "Repairing intent file: $FilePath"
            
            # Remove NEEDS CLARIFICATION markers if present
            if ($Content -match "\[NEEDS CLARIFICATION\]") {
                Write-Host "  - Removing [NEEDS CLARIFICATION] markers"
                $Content = $Content -replace "\[NEEDS CLARIFICATION:[^\]]*\]", ""
                $RepairCount++
            }
            
            # Add missing sections if needed
            if ($Content -notmatch "^# Overview") {
                Write-Host "  - Adding missing 'Overview' section"
                $Content = "# Overview`n`n[Provide a brief overview of the intent]`n`n$Content"
                $RepairCount++
            }
            
            if ($Content -notmatch "^# Functional Requirements") {
                Write-Host "  - Adding missing 'Functional Requirements' section"
                $Content = "$Content`n`n# Functional Requirements`n`n- [Define functional requirements here]"
                $RepairCount++
            }
            
            if ($Content -notmatch "^# Success Criteria") {
                Write-Host "  - Adding missing 'Success Criteria' section"
                $Content = "$Content`n`n# Success Criteria`n`n- [Define success criteria here]"
                $RepairCount++
            }
        }
        {($_ -eq "tasks") -or ($_ -eq "tasks.md")} {
            Write-Host "Repairing tasks file: $FilePath"
            
            # Add task IDs if missing (simple approach)
            $Lines = $Content -split "`n"
            $NewLines = @()
            $TaskCounter = 1
            
            foreach ($Line in $Lines) {
                $TrimmedLine = $Line.TrimStart()
                if ($TrimmedLine -match "^-\s*\[\s*\]\s*(?!T\d{3})" -and $TrimmedLine -notmatch "^\s*-\s*\[\s*\]\s*T\d{3}") {
                    # This looks like a task without an ID, add one
                    $NewLine = $Line -replace "^(\s*-\s*\[\s*\]\s*)", "`${1}T$(($TaskCounter++).ToString('D3')) "
                    $NewLines += $NewLine
                    Write-Host "  - Adding missing task ID to line"
                    $RepairCount++
                } else {
                    $NewLines += $Line
                }
            }
            
            $Content = $NewLines -join "`n"
            
            # Ensure task checkboxes exist where needed
            if ($Content -notmatch "- \[ \]" -and $Content -notmatch "- \[x\]") {
                Write-Host "  - Adding task checkboxes where missing"
                # Add checkboxes to lines that look like tasks
                $Content = $Content -replace "^( *)(-\s+)(.+)$", "`${1}- [ ] `${3}"
                $RepairCount++
            }
        }
        {($_ -eq "plan") -or ($_ -eq "plan.md")} {
            Write-Host "Repairing plan file: $FilePath"
            
            # Add missing sections if needed
            if ($Content -notmatch "^# Architecture|^# Tech Stack") {
                Write-Host "  - Adding missing 'Architecture' section"
                $Content = "# Architecture`n`n[Define the architecture here]`n`n$Content"
                $RepairCount++
            }
            
            if ($Content -notmatch "^# Data Model|^# Entities") {
                Write-Host "  - Adding missing 'Data Model' section"
                $Content = "$Content`n`n# Data Model`n`n[Define data model/entities here]"
                $RepairCount++
            }
        }
        default {
            # Generic repairs
            Write-Host "Performing generic repairs on: $FilePath"
            
            # Fix common markdown issues
            if ($Content.Length -eq 0) {
                Write-Host "  - File is empty, adding basic content"
                $Content = "# Document Title`n`n[Content placeholder]"
                $RepairCount++
            }
        }
    }

    # Write the repaired content back to the file
    $Content | Out-File -FilePath $FilePath -Encoding UTF8

    Write-Host "Repair completed. $RepairCount issues fixed."

    # Store repair learning in the learning context
    $ProjectRoot = Split-Path -Parent (Split-Path -Parent (Split-Path -Parent $PSScriptRoot))
    $LearningContext = Join-Path $ProjectRoot ".intent\learning-context.json"

    if (Test-Path $LearningContext) {
        try {
            # Load existing learning data
            $LearningData = Get-Content $LearningContext -Raw | ConvertFrom-Json -AsHashtable
            
            # Create a record of this repair for learning
            $RepairRecord = @{
                content_type = $ContentType
                repairs_performed = $RepairCount
                repair_date = Get-Date -Format "yyyy-MM-dd"
                file_path = $FilePath
            }
            
            # Add this repair to learned patterns
            if ($LearningData.ContainsKey("learned_patterns")) {
                $LearningData.learned_patterns += $RepairRecord
            } else {
                $LearningData.learned_patterns = @($RepairRecord)
            }
            
            # Update the learning context
            $LearningData | ConvertTo-Json -Depth 10 | Out-File -Encoding UTF8 $LearningContext
        }
        catch {
            # If learning context update fails, continue with repair anyway
            Write-Warning "Could not update learning context: $($_.Exception.Message)"
        }
    }

    # Output repair report
    $ReportObject = @{
        file_path = $FilePath
        content_type = $ContentType
        repairs_performed = $RepairCount
        status = "repaired"
    }
    
    $ReportObject | ConvertTo-Json | Write-Output
}
catch {
    Write-Error "Error during repair: $($_.Exception.Message)"
    exit 1
}