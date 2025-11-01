# PowerShell script to validate generated content quality
# Usage: validate-content.ps1 -FilePath <path> [-ContentType <type>] [-OutputJson <path>] [-ConfigPath <path>]

param(
    [Parameter(Mandatory=$true)]
    [string]$FilePath,
    
    [string]$ContentType = "generic",
    
    [string]$OutputJson,
    
    [string]$ConfigPath
)

try {
    # Validate required parameters
    if (!(Test-Path -Path $FilePath)) {
        Write-Error "File does not exist: $FilePath"
        exit 1
    }

    # Get file stats for validation
    $FileInfo = Get-Item $FilePath
    $FileContent = Get-Content -Path $FilePath -Raw
    $FileLines = $FileContent -split "`n"
    
    # Initialize validation results
    $ValidationIssues = @()
    $PassedChecks = 0
    $TotalChecks = 0

    # Validate content based on type
    switch ($ContentType) {
        {($_ -eq "intent") -or ($_ -eq "intent.md")} {
            # Check for required sections in intent file
            $TotalChecks += 6
            
            if ($FileContent -match "# Overview") {
                $PassedChecks++
            } else {
                $ValidationIssues += "Missing 'Overview' section"
            }
            
            if ($FileContent -match "# Functional Requirements") {
                $PassedChecks++
            } else {
                $ValidationIssues += "Missing 'Functional Requirements' section"
            }
            
            if ($FileContent -match "# Non-Functional Requirements") {
                $PassedChecks++
            } else {
                $ValidationIssues += "Missing 'Non-Functional Requirements' section"
            }
            
            if ($FileContent -match "# User Scenarios") {
                $PassedChecks++
            } else {
                $ValidationIssues += "Missing 'User Scenarios' section"
            }
            
            if ($FileContent -match "# Success Criteria") {
                $PassedChecks++
            } else {
                $ValidationIssues += "Missing 'Success Criteria' section"
            }
            
            if ($FileContent -notmatch "\[NEEDS CLARIFICATION\]") {
                $PassedChecks++
            } else {
                $ValidationIssues += "Contains [NEEDS CLARIFICATION] markers"
            }
        }
        {($_ -eq "tasks") -or ($_ -eq "tasks.md")} {
            # Check for required task format in tasks file
            $TotalChecks += 5
            
            if ($FileContent -match "\- \[ \]" -or $FileContent -match "\- \[x\]") {
                $PassedChecks++
            } else {
                $ValidationIssues += "Missing task checkboxes (- [ ])"
            }
            
            if ($FileContent -match "T\d{3}") {
                $PassedChecks++
            } else {
                $ValidationIssues += "Missing task IDs (T###)"
            }
            
            if ($FileContent -match "src/" -or $FileContent -match "tests/") {
                $PassedChecks++
            } else {
                $ValidationIssues += "Missing file paths in task descriptions"
            }
            
            if ($FileContent -match "US\d+" -or $FileContent -match "IS\d+") {
                $PassedChecks++
            } else {
                # Not a critical issue if user stories aren't required
                $PassedChecks++
            }
            
            if ($FileContent -match "\[P\]") {
                $PassedChecks++
            } else {
                $ValidationIssues += "Missing parallel task markers [P] where appropriate"
            }
        }
        {($_ -eq "plan") -or ($_ -eq "plan.md")} {
            # Check for required sections in plan file
            $TotalChecks += 4
            
            if ($FileContent -match "# Architecture" -or $FileContent -match "# Tech Stack") {
                $PassedChecks++
            } else {
                $ValidationIssues += "Missing 'Architecture' or 'Tech Stack' section"
            }
            
            if ($FileContent -match "# Data Model" -or $FileContent -match "# Entities") {
                $PassedChecks++
            } else {
                $ValidationIssues += "Missing 'Data Model' or 'Entities' section"
            }
            
            if ($FileContent -match "# Phases" -or $FileContent -match "# Implementation Phases") {
                $PassedChecks++
            } else {
                $ValidationIssues += "Missing 'Phases' section"
            }
            
            if ($FileContent -match "# Quality Gates" -or $FileContent -match "# Validation Criteria") {
                $PassedChecks++
            } else {
                $ValidationIssues += "Missing 'Quality Gates' or 'Validation Criteria' section"
            }
        }
        default {
            # Generic validation for any content
            $TotalChecks = 3
            
            if ($FileContent.Length -gt 0) {
                $PassedChecks++
            } else {
                $ValidationIssues += "File is empty"
            }
            
            if ($FileContent -match "^# " -or $FileContent -match "^## " -cmatch "(?m)^# " -or $FileContent -match "(?m)^## ") {
                $PassedChecks++
            } else {
                $ValidationIssues += "Missing markdown headings"
            }
            
            if ($FileContent -match "[a-zA-Z]") {
                $PassedChecks++
            } else {
                $ValidationIssues += "File doesn't contain readable text"
            }
        }
    }

    # Calculate pass rate
    if ($TotalChecks -gt 0) {
        $PassRate = [math]::Round($PassedChecks / $TotalChecks, 2)
    } else {
        $PassRate = 1.0
    }

    # Determine validation status
    if ($ValidationIssues.Count -eq 0) {
        $ValidationStatus = "pass"
    } else {
        $ValidationStatus = "fail"
    }

    # Create validation report object
    $ReportObject = @{
        file_path = $FilePath
        file_name = $FileInfo.Name
        file_size = $FileInfo.Length
        content_type = $ContentType
        validation_status = $ValidationStatus
        total_checks = $TotalChecks
        passed_checks = $PassedChecks
        pass_rate = $PassRate
        issues = $ValidationIssues
    }

    # Convert to JSON and output
    $ReportJson = $ReportObject | ConvertTo-Json -Depth 10
    Write-Output $ReportJson

    # Save to file if output path specified
    if ($OutputJson) {
        $ReportJson | Out-File -FilePath $OutputJson -Encoding UTF8
        Write-Output "Validation report saved to: $OutputJson"
    }

    # Calculate quality score based on pass rate (0-10 scale)
    if ($TotalChecks -gt 0) {
        $QualityScore = [math]::Round($PassRate * 10, 2)
    } else {
        $QualityScore = 10
    }

    # Identify specific failure patterns for learning
    $FailurePatterns = @()
    if ($ValidationStatus -eq "fail") {
        foreach ($Issue in $ValidationIssues) {
            switch -Wildcard ($Issue) {
                "*Missing 'Overview' section*" { 
                    $FailurePatterns += "missing_intent_overview"
                    break
                }
                "*Missing 'Functional Requirements' section*" { 
                    $FailurePatterns += "missing_intent_functional_reqs" 
                    break
                }
                "*Contains [NEEDS CLARIFICATION] markers*" { 
                    $FailurePatterns += "intent_underspecification" 
                    break
                }
                "*Missing task checkboxes*" { 
                    $FailurePatterns += "malformed_tasks_format" 
                    break
                }
                "*Missing task IDs*" { 
                    $FailurePatterns += "malformed_tasks_format" 
                    break
                }
                "*Missing file paths in task descriptions*" { 
                    $FailurePatterns += "missing_task_file_paths" 
                    break
                }
                "*Missing parallel task markers*" { 
                    $FailurePatterns += "missing_parallel_task_markers" 
                    break
                }
                "*Missing 'Architecture' or 'Tech Stack' section*" { 
                    $FailurePatterns += "missing_plan_architecture" 
                    break
                }
                "*Missing 'Data Model' or 'Entities' section*" { 
                    $FailurePatterns += "missing_plan_data_model" 
                    break
                }
                "*File is empty*" { 
                    $FailurePatterns += "empty_file" 
                    break
                }
                "*Missing markdown headings*" { 
                    $FailurePatterns += "missing_headings_format" 
                    break
                }
            }
        }
    }

    # Output quality score (for tracking metrics)
    Write-Host "QUALITY_SCORE: $QualityScore"  # This goes to stderr when captured by the calling script

    # Output failure patterns if any exist
    if ($FailurePatterns.Count -gt 0) {
        $FailurePatternsStr = $FailurePatterns -join ","
        Write-Host "FAILURE_PATTERNS: $FailurePatternsStr"
    }

    # Exit with error code if validation failed
    if ($ValidationStatus -eq "fail") {
        exit 1
    }
}
catch {
    Write-Error "Error during validation: $($_.Exception.Message)"
    exit 1
}