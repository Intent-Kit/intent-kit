---
description: Generate a report of the Intent Kit Reliability Index showing success rates, retries, and quality scores over time.
scripts:
  sh: scripts/bash/report-reliability-index.sh
  ps: scripts/powershell/report-reliability-index.ps1
---

## Intent Kit Reliability Index Report

This command generates a comprehensive report of the Intent Kit Reliability Index, which measures:

- **% of runs passing validation first try** (success rate)
- **Average retries needed per run**
- **Average quality score** of generated content
- **Daily tracking** of metrics
- **Trend analysis** over time

### Metrics Explained

- **Success Rate**: Percentage of runs that pass validation on the first try without needing repairs
- **Avg Retries**: Average number of repair iterations needed when validation fails initially
- **Avg Score**: Average quality score (0-10 scale) based on validation criteria
- **Reliability Index**: Overall score representing the system's consistency and quality

### Report Sections

The report includes:

1. **Overall Reliability Index**: Current aggregated metrics
2. **Daily Metrics**: Day-by-day breakdown of performance
3. **Trend Analysis**: Comparison between earliest and latest metrics to show improvement/deterioration

### Execution

This command will execute `{SCRIPT}` to generate the full reliability report from the collected metrics in `.intent/metrics/`.

### User Input

```text
$ARGUMENTS
```

You **MUST** consider the user input before proceeding (if not empty).

The report will be displayed directly in the output and can be used to assess the quality and reliability of the intent-kit system over time.
