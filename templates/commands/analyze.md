---
description: Perform a non-destructive cross-artifact consistency and quality analysis across intent.md, plan.md, and tasks.md after task generation, ensuring methodological integrity.
scripts:
  sh: scripts/bash/check-prerequisites.sh --json --require-tasks --include-tasks
  ps: scripts/powershell/check-prerequisites.ps1 -Json -RequireTasks -IncludeTasks
save_run_report_script:
  sh: scripts/bash/save-run-report.sh
  ps: scripts/powershell/save-run-report.ps1
validate_script:
  sh: scripts/bash/validate-content.sh
  ps: scripts/powershell/validate-content.ps1
repair_script:
  sh: scripts/bash/repair-content.sh
  ps: scripts/powershell/repair-content.ps1
track_metrics_script:
  sh: scripts/bash/track-metrics.sh
  ps: scripts/powershell/track-metrics.ps1
adaptive_learning_script:
  sh: scripts/bash/adaptive-learning.sh
  ps: scripts/powershell/adaptive-learning.ps1
---

## User Input

```text
$ARGUMENTS
```

You **MUST** consider the user input before proceeding (if not empty).

## Intent Methodology Application

**CRITICAL**: You MUST actively apply the intent methodology's validation principles throughout analysis. The methodology must guide how you identify issues and validate artifacts.

**Required Methodology Application:**

**Scholar Archetype Application (MUST PERFORM EXPLICITLY):**

1. **Analytical Approach**:
   - Apply analytical reasoning to identify inconsistencies
   - Use systematic comparison across artifacts
   - Document evidence for each finding (quote specific sections)
   - **Validation**: Can you provide specific evidence for each issue?

2. **Reason-Driven Validation**:
   - For each finding, explain WHY it's an issue (not just WHAT is wrong)
   - Trace each issue to methodology principle violations
   - Justify severity assignment with reasoning
   - **Validation**: Can you explain why each finding matters?

3. **Documented Assessment**:
   - Provide structured evidence for each finding
   - Include location references (file:line)
   - Explain impact on intent integrity
   - **Validation**: Is your assessment well-documented?

**Quality Assurance Framework (MUST PERFORM EXPLICITLY):**

1. **Core Philosophy Validation**:
   - Check direction_over_description: Are requirements focused on driving force?
   - Check guided_agency: Are reasonable defaults used without over-asking?
   - Check contextual_continuity: Is terminology consistent across artifacts?
   - **Validation**: Can you verify each philosophy principle is followed?

2. **Design Archetype Consistency**:
   - Identify the archetype selected in plan.md
   - Verify intent.md, plan.md, and tasks.md align with archetype approach
   - Check if archetype traits are reflected in all artifacts
   - **Validation**: Is the archetype consistently applied?

3. **Action Tendencies Validation**:
   - Verify verbose naming patterns in tasks.md and plan.md
   - Check for abstract-level commenting guidance
   - Verify scenario-driven thinking in intent.md and tasks.md
   - **Validation**: Are action tendencies evident in artifacts?

4. **Rules Compliance**:
   - Verify simplicity over cleverness (no over-engineering)
   - Verify readability is longevity (clear, understandable)
   - Verify fail fast refine later (incremental, testable approach)
   - **Validation**: Do artifacts follow methodology rules?

**Contextual Continuity Validation (MUST PERFORM EXPLICITLY):**

1. **Consistent Intent Context**:
   - Verify terminology matches between intent.md, plan.md, and tasks.md
   - Check that user stories from intent.md appear in tasks.md
   - Verify entities from intent.md appear in plan.md data-model.md
   - **Validation**: Is context maintained across artifacts?

2. **Methodology Integration**:
   - Verify operational model stages were applied:
     - Impulse/Extraction: Are intent signals clear and structured?
     - Shaping: Is design archetype selected and applied?
     - Injection: Is intent context integrated in all artifacts?
     - Modulation: Are action tendencies and biases applied?
   - **Validation**: Can you trace methodology application in artifacts?

3. **Bias Principles Consistency**:
   - Verify functional purity approach in plan.md and tasks.md
   - Check minimalist UX approach in intent.md user stories
   - Verify modular composition in plan.md architecture
   - **Validation**: Are bias principles consistently applied?

## Goal

Identify inconsistencies, duplications, ambiguities, and underspecified items across the three core artifacts (`intent.md`, `plan.md`, `tasks.md`) before implementation. This command MUST run only after `/intent.tasks` has successfully produced a complete `tasks.md`.

## Operating Constraints

**STRICTLY READ-ONLY**: Do **not** modify any files. Output a structured analysis report. Offer an optional remediation plan (user must explicitly approve before any follow-up editing commands would be invoked manually).

**Constitution Authority**: The project constitution (`/memory/constitution.md`) is **non-negotiable** within this analysis scope. Constitution conflicts are automatically CRITICAL and require adjustment of the intent, plan, or tasks—not dilution, reinterpretation, or silent ignoring of the principle. If a principle itself needs to change, that must occur in a separate, explicit constitution update outside `/intent.analyze`.

## Execution Steps

### 1. Initialize Analysis Context

Run `{SCRIPT}` once from repo root and parse JSON for FEATURE_DIR and AVAILABLE_DOCS. Derive absolute paths:

- SPEC = FEATURE_DIR/intent.md
- PLAN = FEATURE_DIR/plan.md
- TASKS = FEATURE_DIR/tasks.md

Abort with an error message if any required file is missing (instruct the user to run missing prerequisite command).
For single quotes in args like "I'm Groot", use escape syntax: e.g 'I'\''m Groot' (or double-quote if possible: "I'm Groot").

### 2. Load Artifacts (Progressive Disclosure)

Load only the minimal necessary context from each artifact:

**From intent.md:**

- Overview/Context
- Functional Requirements
- Non-Functional Requirements
- User Stories
- Edge Cases (if present)

**From plan.md:**

- Architecture/stack choices
- Data Model references
- Phases
- Technical constraints

**From tasks.md:**

- Task IDs
- Descriptions
- Phase grouping
- Parallel markers [P]
- Referenced file paths

**From constitution:**

- Load `/memory/constitution.md` for principle validation

### 3. Build Semantic Models

Create internal representations (do not include raw artifacts in output):

- **Requirements inventory**: Each functional + non-functional requirement with a stable key (derive slug based on imperative phrase; e.g., "User can upload file" → `user-can-upload-file`)
- **User story/action inventory**: Discrete user actions with acceptance criteria
- **Task coverage mapping**: Map each task to one or more requirements or stories (inference by keyword / explicit reference patterns like IDs or key phrases)
- **Constitution rule set**: Extract principle names and MUST/SHOULD normative statements

### 4. Detection Passes (Token-Efficient Analysis)

Focus on high-signal findings. Limit to 50 findings total; aggregate remainder in overflow summary.

**CRITICAL**: Prioritize findings that would cause implementation bugs:

- Task format errors (would break task parsing)
- Missing file paths (would cause implementation to fail)
- Invalid dependencies (would cause execution order errors)
- Missing requirements coverage (would cause incomplete implementation)

#### A. Duplication Detection

- Identify near-duplicate requirements
- Mark lower-quality phrasing for consolidation

#### B. Ambiguity Detection

- Flag vague adjectives (fast, scalable, secure, intuitive, robust) lacking measurable criteria
- Flag unresolved placeholders (TODO, TKTK, ???, `<placeholder>`, etc.)

#### C. Underspecification

- Requirements with verbs but missing object or measurable outcome
- User stories missing acceptance criteria alignment
- Tasks referencing files or components not defined in intent/plan

#### D. Constitution Alignment

- Any requirement or plan element conflicting with a MUST principle
- Missing mandated sections or quality gates from constitution

#### E. Coverage Gaps

- Requirements with zero associated tasks
- Tasks with no mapped requirement/story
- Non-functional requirements not reflected in tasks (e.g., performance, security)

#### F. Inconsistency

- Terminology drift (same concept named differently across files)
- Data entities referenced in plan but absent in intent (or vice versa)
- Task ordering contradictions (e.g., integration tasks before foundational setup tasks without dependency note)
- Conflicting requirements (e.g., one requires Next.js while other specifies Vue)

#### G. Task Quality Issues

- Tasks with incomplete descriptions (missing file paths, vague actions)
- Tasks missing required format components (checkbox, ID, labels)
- Tasks with invalid dependencies (referencing non-existent tasks)
- Tasks with incorrect parallel markers [P] (has dependencies but marked parallel)
- Tasks missing user story labels [US#] when required
- Tasks with file paths that don't match project structure in plan.md

### 5. Severity Assignment

Use this heuristic to prioritize findings:

- **CRITICAL**: Violates constitution MUST, missing core intent artifact, or requirement with zero coverage that blocks baseline functionality
- **HIGH**: Duplicate or conflicting requirement, ambiguous security/performance attribute, untestable acceptance criterion
- **MEDIUM**: Terminology drift, missing non-functional task coverage, underspecified edge case
- **LOW**: Style/wording improvements, minor redundancy not affecting execution order

### 6. Produce Compact Analysis Report

Output a Markdown report (no file writes) with the following structure:

## Specification Analysis Report

| ID | Category | Severity | Location(s) | Summary | Recommendation |
|----|----------|----------|-------------|---------|----------------|
| A1 | Duplication | HIGH | intent.md:L120-134 | Two similar requirements ... | Merge phrasing; keep clearer version |

(Add one row per finding; generate stable IDs prefixed by category initial.)

**Coverage Summary Table:**

| Requirement Key | Has Task? | Task IDs | Notes |
|-----------------|-----------|----------|-------|

**Constitution Alignment Issues:** (if any)

**Unmapped Tasks:** (if any)

**Metrics:**

- Total Requirements
- Total Tasks
- Coverage % (requirements with >=1 task)
- Ambiguity Count
- Duplication Count
- Critical Issues Count

### 7. Provide Next Actions

At end of report, output a concise Next Actions block:

- If CRITICAL issues exist: Recommend resolving before `/intent.implement`
- If only LOW/MEDIUM: User may proceed, but provide improvement suggestions
- Provide explicit command suggestions: e.g., "Run /intent.capture with refinement", "Run /intent.plan to adjust architecture", "Manually edit tasks.md to add coverage for 'performance-metrics'"

### 8. Offer Remediation

Ask the user: "Would you like me to suggest concrete remediation edits for the top N issues?" (Do NOT apply them automatically.)

## Operating Principles

### Context Efficiency

- **Minimal high-signal tokens**: Focus on actionable findings, not exhaustive documentation
- **Progressive disclosure**: Load artifacts incrementally; don't dump all content into analysis
- **Token-efficient output**: Limit findings table to 50 rows; summarize overflow
- **Deterministic results**: Rerunning without changes should produce consistent IDs and counts

### Analysis Guidelines

- **NEVER modify files** (this is read-only analysis)
- **NEVER hallucinate missing sections** (if absent, report them accurately)
- **Prioritize constitution violations** (these are always CRITICAL)
- **Use examples over exhaustive rules** (cite specific instances, not generic patterns)
- **Report zero issues gracefully** (emit success report with coverage statistics)

## Context

{ARGS}

## Validation and Repair Stage

**After analysis report generation, execute validation/repair loop:**

1. **Validate Content Quality**: Execute `{VALIDATE_SCRIPT} --file ANALYSIS_REPORT --content-type analysis`
   - If validation passes (`status: pass`), proceed to run report generation
   - If validation fails (`status: fail`), continue to repair step

2. **Repair Content (if needed)**: Execute `{REPAIR_SCRIPT} --file ANALYSIS_REPORT --content-type analysis`
   - Re-validate the repaired content
   - If re-validation passes, proceed to run report generation
   - If re-validation fails, document issues and proceed to run report with `status: repaired`

3. **Update Run Report Values**: Adjust run report parameters based on validation/repair outcome:
   - **validator_pass_rate**: From validation report
   - **status**: `pass` (if validation passed without repair), `repaired` (if repair was needed)
   - **retries**: Number of repair iterations performed
   - **score**: Quality score based on validation results

## Run Report Generation

**Upon completion of analysis, generate and save run report:**

- **Create run_report.json**: After analysis report is complete
- **Structure**:

  ```json
  {
    "intent_id": "<FEATURE_DIR_NAME>",
    "status": "pass|fail|repaired",
    "validator_pass_rate": 0.82,
    "retries": 1,
    "score": 78,
    "timestamp": "2025-11-01T08:45:00Z"
  }
  ```

- **Save location**: `.intent/metrics/run_report_<TIMESTAMP>.json` where TIMESTAMP is YYYYMMDD_HHMMSS
- **Implementation**: Execute `{SAVE_RUN_REPORT_SCRIPT}` with appropriate parameters
- **Validate**: Ensure metrics directory exists at `.intent/metrics/`

**Script Execution**:

- Bash: `{SAVE_RUN_REPORT_SCRIPT} --intent-id <FEATURE_DIR_NAME> --status pass --validator-pass-rate 1.0 --retries 0 --score 100`
- PowerShell: `{SAVE_RUN_REPORT_SCRIPT} -IntentId <FEATURE_DIR_NAME> -Status pass -ValidatorPassRate 1.0 -Retries 0 -Score 100`

## Metrics Tracking and Reliability Index

**Track analysis metrics to calculate Intent Kit Reliability Index:**

- **Update reliability metrics**: Execute `{SH}` or `{PS}` with validation and retry information
- **Metrics tracked**: % of runs passing validation first try, avg_retries, avg_score
- **Daily tracking**: Metrics aggregated by date in `.intent/metrics/YYYY-MM-DD-metrics.json`
- **Overall index**: Updated in `.intent/metrics/reliability-index.json`

**Script Execution**:

- Bash: `{SH} [success|run] [retries_count] [score_value]`
  - Use "success" if validation passed on first try, "run" otherwise
  - Pass number of retries performed during validation/repair
  - Pass quality score from validation (0.0-10.0 scale)
- PowerShell: `{PS} -Status [success|run] -Retries [retries_count] -Score [score_value]`

## Adaptive Learning

**Apply adaptive learning to improve future generations:**

- **Analyze metrics and adjust**: Execute `{SH}` or `{PS}` to identify patterns and improve future performance
- **Update learning context**: Based on current metrics and failure patterns
- **Apply improvement strategies**: Adjust generation approach based on learned patterns

**Script Execution**:

- Bash: `{SH}`
- PowerShell: `{PS}` (no parameters needed)
