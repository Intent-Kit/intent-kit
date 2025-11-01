# Intent Kit Reliability Index

The Intent Kit now tracks reliability metrics through the Intent Kit Reliability Index, which measures:

- **Success Rate**: % of runs passing validation first try
- **Avg Retries**: Average number of retries needed when initial validation fails
- **Avg Score**: Average quality score of generated content (0-10 scale)

## Metrics Collection

Each intent command now includes metrics tracking that collects data on:

- Whether the content passed validation on the first try
- How many repair attempts were needed
- Quality score based on validation criteria
- Specific failure patterns detected during validation

## Daily Tracking

Metrics are aggregated by day in `.intent/metrics/YYYY-MM-DD-metrics.json` and an overall reliability index is maintained in `.intent/metrics/reliability-index.json`.

## Adaptive Learning

The system now includes **adaptive learning capabilities** that:

- **Identify failure patterns** during validation (e.g., missing sections, format issues, underspecification)
- **Analyze trends** in success rates, retries, and quality scores
- **Automatically adjust** the generation approach based on learned patterns
- **Store learning context** in `.intent/learning-context.json`
- **Create adaptive guidance** in `.intent/adaptive-context.md` that influences future generations

The adaptive learning system specifically detects and learns from:

- Missing intent sections (Overview, Requirements, etc.)
- Task format issues (missing checkboxes, IDs, file paths)
- Plan structure problems (missing architecture, data model)
- Quality issues that cause repeated repairs

### Self-Improvement Loop

After each command execution, the system now performs:

1. **Metrics tracking** - Record success rate, retries, quality score
2. **Repair learning** - Store what repairs were performed
3. **Pattern analysis** - Identify common failure modes
4. **Adaptive adjustment** - Update generation approach for future runs
5. **Context updating** - Provide learned insights to the AI agent

### Viewing Reports

Use the `/intent.reliability` command to generate a comprehensive report of the reliability index, including:

- Overall reliability score
- Daily metrics breakdown
- Trend analysis over time
- Learned improvement strategies
- Adaptive context that's been built up over time
