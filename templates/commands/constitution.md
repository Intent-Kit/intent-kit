---
description: Establish the project constitution following intent methodology's motive and principle layers, ensuring contextual_continuity across all development activities
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

**CRITICAL**: You MUST actively apply the intent methodology's motive and principle layers throughout constitution establishment. The constitution IS the foundation of the intent methodology - it defines the principles, biases, modes, and action tendencies that all other commands will apply.

**Required Methodology Application:**

**Motive Layer (MUST PERFORM EXPLICITLY):**

1. **Define the Driving Force**:
   - Identify WHY this developer/project exists (not WHAT it does)
   - Capture the human motivation behind the project
   - Express as a directive that guides all decisions
   - Example: "Empower indie devs to ship faster without losing soul"
   - **Validation**: Can you articulate the driving force in one sentence? Does it express WHY, not WHAT?

2. **Apply Impulse Stage**:
   - Read any existing project context (README, docs, user input)
   - Identify the emotional tone or motivation (ambition, frustration, vision, etc.)
   - Capture the underlying human need this project addresses
   - Document: What is the core motivation this constitution must serve?
   - **Validation**: Have you captured the human motivation, not just technical goals?

**Principle Layer (MUST PERFORM EXPLICITLY):**

1. **Establish Core Philosophy**:
   - Define principles that embody direction_over_description
   - Ensure principles focus on driving force, not static rules
   - Principles should guide decisions, not prescribe implementation
   - **Validation**: Do your principles express direction/guidance, not detailed prescriptions?

2. **Establish Governing Rules**:
   - Define rules that capture: Simplicity over cleverness, readability is longevity, fail fast refine later
   - Ensure rules are declarative, testable, and actionable
   - Rules should be non-negotiable (MUST) or guiding (SHOULD)
   - **Validation**: Are your rules testable and actionable?

3. **Define Bias Principles**:
   - Establish reasoning_style bias (e.g., Functional purity)
   - Establish design_bias (e.g., Minimalist UX)
   - Establish architecture_bias (e.g., Modular composition)
   - Document how each bias guides decisions
   - **Validation**: Do your biases guide decision-making style?

4. **Define Modes**:
   - Establish available modes (hack_fast, refine, audit, polish)
   - Define when each mode is appropriate
   - Document default mode if applicable
   - **Validation**: Do modes support different implementation styles?

5. **Define Action Tendencies**:
   - Establish naming convention tendency (e.g., Verbose)
   - Establish commenting approach (e.g., Abstract-level guidance)
   - Establish testing approach (e.g., Scenario-driven)
   - Establish refactoring approach (e.g., As-you-go)
   - **Validation**: Do action tendencies guide code generation style?

**Shaping Stage Application (MUST PERFORM EXPLICITLY):**

1. **Select Design Archetypes** (if appropriate):
   - Document which archetypes (architect/hacker/craftsman/scholar/zen_coder) align with project
   - Establish which archetype traits to emphasize
   - Ensure archetype selection aligns with motive layer
   - **Validation**: Does archetype selection serve the driving force?

**Contextual Continuity (MUST PERFORM EXPLICITLY):**

1. **Ensure Persistent Cognitive Stance**:
   - Constitution must provide consistent guidance across all sessions
   - Principles must be stable yet actionable
   - Document how constitution guides subsequent phases (intent, plan, tasks, implement)
   - **Validation**: Will this constitution provide consistent guidance?

2. **Align with Intent Methodology Framework**:
   - Ensure principles align with intent methodology core philosophy
   - Ensure biases support intent methodology operational model
   - Ensure action tendencies match intent methodology expectations
   - **Validation**: Does this constitution align with intent methodology framework?

**Methodology Validation Checkpoint:**

Before completing constitution.md, verify:

- [ ] Motive layer captures WHY (driving force), not WHAT (features)
- [ ] Principles express direction_over_description (guidance, not prescriptions)
- [ ] Rules are declarative, testable, and actionable
- [ ] Bias principles guide decision-making style
- [ ] Action tendencies guide code generation style
- [ ] Constitution will provide consistent guidance across all phases
- [ ] Constitution aligns with intent methodology framework

## Outline

You are updating the project constitution at `/memory/constitution.md`. This file is a TEMPLATE containing placeholder tokens in square brackets (e.g. `[PROJECT_NAME]`, `[PRINCIPLE_1_NAME]`). Your job is to (a) collect/derive concrete values, (b) fill the template precisely by replacing all placeholders, and (c) validate consistency with dependent artifacts (DO NOT modify template files - they are read-only).

Follow this execution flow, applying intent methodology layers:

**BEFORE proceeding with constitution generation, you MUST execute the methodology stages above and document your methodology application.**

1. **Execute Motive Layer Application**:
   - Read any existing project context (README, docs, existing constitution if present, user input)
   - Apply impulse stage: Identify the human motivation behind this project
   - Define the driving force: WHY does this project exist? (Not WHAT it does)
   - Express as a directive that guides all decisions
   - Document your motive establishment before proceeding
   - Fill `[PROJECT_NAME]` with the project name
   - Fill motive-related placeholders based on driving force

   **IMPORTANT**: The user might require less or more principles than the ones used in the template. If a number is specified, respect that - follow the general template. You will update the doc accordingly.

2. **Execute Principle Layer Application**:
   - Apply shaping stage: Analyze the motive to determine what principles are needed
   - Establish governing rules that embody core philosophy:
     - **direction_over_description**: Principles should guide decisions, not prescribe details
     - **guided_agency**: Principles should enable informed choices
     - **contextual_continuity**: Principles should provide consistent guidance
   - Collect/derive values for placeholders:
     - If user input supplies values, use them, following guided_agency principle
     - Otherwise infer from existing repo context (README, docs, prior constitution versions if embedded)
     - Ensure each principle is: declarative, testable, actionable
     - Ensure principles express direction/guidance, not detailed prescriptions
   - Define bias principles:
     - **reasoning_style**: Establish bias (e.g., Functional purity)
     - **design_bias**: Establish bias (e.g., Minimalist UX)
     - **architecture_bias**: Establish bias (e.g., Modular composition)
   - Define action tendencies:
     - **naming**: Establish convention (e.g., Verbose)
     - **commenting**: Establish approach (e.g., Abstract-level guidance)
     - **testing**: Establish approach (e.g., Scenario-driven)
     - **refactoring**: Establish approach (e.g., As-you-go)
   - For governance dates: `RATIFICATION_DATE` is the original adoption date (if unknown ask or mark TODO), `LAST_AMENDED_DATE` is today if changes are made, otherwise keep previous.
   - `CONSTITUTION_VERSION` must increment according to semantic versioning rules:
     - MAJOR: Backward incompatible governance/principle removals or redefinitions.
     - MINOR: New principle/section added or materially expanded guidance.
     - PATCH: Clarifications, wording, typo fixes, non-semantic refinements.
   - If version bump type ambiguous, propose reasoning before finalizing.
   - Document your principle definitions and how they align with intent methodology

3. **Execute Contextual Continuity Establishment**:
   - Apply injection stage: Integrate intent methodology framework into constitution
   - Ensure constitution provides persistent cognitive stance:
     - Principles must be stable yet actionable
     - Constitution must guide all subsequent phases (intent, plan, tasks, implement)
     - Constitution must align with intent methodology operational model
   - Draft the updated constitution content:
     - Replace every placeholder with concrete text (no bracketed tokens left except intentionally retained template slots—explicitly justify any left), following direction_over_description principle.
     - Preserve heading hierarchy and comments can be removed once replaced unless they still add clarifying guidance.
     - Ensure each Principle section: succinct name line, paragraph (or bullet list) capturing non‑negotiable rules, explicit rationale if not obvious.
     - Ensure Governance section lists amendment procedure, versioning policy, and compliance review expectations.
   - Document how this constitution will guide intent methodology application

4. Consistency validation checklist (READ-ONLY verification, DO NOT modify template files):
   - **IMPORTANT**: Templates (`/templates/*.md`) are SHARED templates and MUST NOT be modified. They will be used by other commands (`/intent.plan`, `/intent.capture`, etc.) and should remain generic.
   - Read `/templates/plan-template.md` and verify that the "Constitution Check" section structure is compatible with your updated principles (DO NOT modify the template).
   - Read `/templates/intent-template.md` and verify scope/requirements structure is compatible (DO NOT modify the template).
   - Read `/templates/tasks-template.md` and verify task categorization structure is compatible (DO NOT modify the template).
   - Note any incompatibilities in the Sync Impact Report as "⚠ pending" - these will be handled by the commands that use those templates.
   - Read any runtime guidance docs (e.g., `README.md`, `docs/quickstart.md`, or agent-specific guidance files if present). These CAN be updated if they contain outdated principle references.

5. Produce a Sync Impact Report (prepend as an HTML comment at top of the constitution file after update):
   - Version change: old → new
   - List of modified principles (old title → new title if renamed)
   - Added sections
   - Removed sections
   - Templates compatibility check (⚠ pending - templates are read-only, will be handled by other commands):
     - `/templates/plan-template.md` - Constitution Check section compatible
     - `/templates/intent-template.md` - Structure compatible
     - `/templates/tasks-template.md` - Task categorization compatible
   - Runtime docs updated (if any): List files that were updated
   - Follow-up TODOs if any placeholders intentionally deferred.

6. **Methodology Validation** (before final output):

   **Constitution Quality Validation**:

   - [ ] Motive layer captures WHY (driving force), not WHAT (features)
   - [ ] Principles express direction_over_description (guidance, not prescriptions)
   - [ ] Rules are declarative, testable, and actionable
   - [ ] Bias principles guide decision-making style
   - [ ] Action tendencies guide code generation style
   - [ ] Constitution will provide consistent guidance across all phases
   - [ ] Constitution aligns with intent methodology framework

   **Technical Validation**:

   - [ ] No remaining unexplained bracket tokens
   - [ ] Version line matches report
   - [ ] Dates ISO format YYYY-MM-DD
   - [ ] Principles are declarative, testable, and free of vague language ("should" → replace with MUST/SHOULD rationale where appropriate)
   - [ ] Principles use clear normative language (MUST for required, SHOULD for recommended)
   - [ ] Constitution structure follows template structure

7. Write the completed constitution back to `/memory/constitution.md` (overwrite).
   - **CRITICAL**: Only write to `/memory/constitution.md`. DO NOT modify any files in `/templates/` directory.

8. Output a final summary to the user with:
   - New version and bump rationale.
   - Any files flagged for manual follow-up.
   - Suggested commit message (e.g., `docs: amend constitution to vX.Y.Z (principle additions + governance update)`).

Formatting & Style Requirements:

- Use Markdown headings exactly as in the template (do not demote/promote levels).
- Wrap long rationale lines to keep readability (<100 chars ideally) but do not hard enforce with awkward breaks.
- Keep a single blank line between sections.
- Avoid trailing whitespace.

If the user supplies partial updates (e.g., only one principle revision), still perform validation and version decision steps.

If critical info missing (e.g., ratification date truly unknown), insert `TODO(<FIELD_NAME>): explanation` and include in the Sync Impact Report under deferred items.

Do not create a new template; always operate on the existing `/memory/constitution.md` file.

## Validation and Repair Stage

**After constitution update and initial validation, execute validation/repair loop:**

1. **Validate Content Quality**: Execute `{VALIDATE_SCRIPT} --file "/memory/constitution.md" --content-type constitution`
   - If validation passes (`status: pass`), proceed to run report generation
   - If validation fails (`status: fail`), continue to repair step

2. **Repair Content (if needed)**: Execute `{REPAIR_SCRIPT} --file "/memory/constitution.md" --content-type constitution` 
   - Re-validate the repaired content
   - If re-validation passes, proceed to run report generation
   - If re-validation fails, document issues and proceed to run report with `status: repaired`

3. **Update Run Report Values**: Adjust run report parameters based on validation/repair outcome:
   - **validator_pass_rate**: From validation report
   - **status**: `pass` (if validation passed without repair), `repaired` (if repair was needed)
   - **retries**: Number of repair iterations performed
   - **score**: Quality score based on validation results

## Run Report Generation

**Upon completion of constitution update, generate and save run report:**

- **Create run_report.json**: After constitution file is updated and validation complete
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

**Track constitution update metrics to calculate Intent Kit Reliability Index:**

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
