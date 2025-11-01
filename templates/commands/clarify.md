---
description: Identify underspecified areas in the current intent intent by asking up to 5 highly targeted clarification questions and encoding answers back into the intent, following extraction and shaping stages.
scripts:
   sh: scripts/bash/check-prerequisites.sh --json --paths-only
   ps: scripts/powershell/check-prerequisites.ps1 -Json -PathsOnly
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

**CRITICAL**: You MUST actively apply the intent methodology's extraction and shaping stages throughout clarification. The methodology must guide how you identify gaps and integrate clarifications.

**Required Methodology Execution:**

### Stage 1: Extraction Stage Refinement (MUST PERFORM EXPLICITLY)

When identifying clarification needs, you MUST:

1. **Re-parse Intent Signals**:
   - Re-read intent.md with extraction mindset
   - Identify gaps in structured signals (missing actors, actions, objects, constraints)
   - Normalize terminology to find inconsistencies
   - Document: What signals are incomplete or ambiguous?

2. **Apply Extraction to Gap Analysis**:
   - For each ambiguity, identify which intent signal is missing:
     - Missing actor? (Who needs this feature)
     - Missing action? (What should happen)
     - Missing object? (What things are involved)
     - Missing constraint? (When/where/why conditions)
   - Prioritize gaps by impact on implementation
   - Document extraction findings before asking questions

### Stage 2: Shaping Stage Integration (MUST PERFORM EXPLICITLY)

When integrating clarifications, you MUST:

1. **Re-weight Motives, Biases, and Modes**:
   - Analyze clarification answers to determine if archetype selection needs adjustment
   - Determine if implementation mode should change based on clarified priorities
   - Document: How do clarifications affect shaping decisions?

2. **Apply Guided Agency**:
   - When user provides clarification, incorporate it guided_agency style:
     - Make informed interpretations of their answer
     - Apply reasonable defaults for implied details
     - Don't ask follow-up questions for obvious interpretations
   - Document: How did you apply guided_agency to interpret clarifications?

3. **Form Refined Approach**:
   - Update understanding of implementation approach based on clarifications
   - Adjust archetype selection if clarifications reveal different priorities
   - Document: How did clarifications refine your approach?

### Stage 3: Contextual Continuity Maintenance (MUST PERFORM EXPLICITLY)

When updating intent.md with clarifications, you MUST:

1. **Maintain Consistent Context**:
   - Integrate clarifications using terminology from original intent.md
   - Preserve intent.md structure and organization
   - Ensure clarifications align with existing user stories and requirements
   - Document: How did you maintain context while adding clarifications?

2. **Validate Methodology Alignment**:
   - Ensure clarified requirements align with core philosophy
   - Verify clarifications don't violate bias principles
   - Confirm clarifications support selected design archetype
   - Document: How do clarifications align with methodology?

**Clarification Integration Validation**:

After integrating each clarification, verify:

- [ ] Clarification maintains terminology consistency with intent.md
- [ ] Clarification aligns with selected design archetype
- [ ] Clarification supports core philosophy (direction_over_description, guided_agency, contextual_continuity)
- [ ] Clarification preserves intent.md structure
- [ ] Clarification doesn't contradict existing requirements

## Outline

Goal: Detect and reduce ambiguity or missing decision points in the active intent specification and record the clarifications directly in the intent file.

Note: This clarification workflow is expected to run (and be completed) BEFORE invoking `/intent.plan`. If the user explicitly states they are skipping clarification (e.g., exploratory spike), you may proceed, but must warn that downstream rework risk increases.

Execution steps:

1. Run `{SCRIPT}` from repo root **once** (combined `--json --paths-only` mode / `-Json -PathsOnly`). Parse minimal JSON payload fields:
   - `FEATURE_DIR`
   - `FEATURE_SPEC`
   - (Optionally capture `IMPL_PLAN`, `TASKS` for future chained flows.)
   - If JSON parsing fails, abort and instruct user to re-run `/intent.capture` or verify intent branch environment.
   - For single quotes in args like "I'm Groot", use escape syntax: e.g 'I'\''m Groot' (or double-quote if possible: "I'm Groot").

2. Load the current intent file. Perform a structured ambiguity & coverage scan using this taxonomy. For each category, mark status: Clear / Partial / Missing. Produce an internal coverage map used for prioritization (do not output raw map unless no questions will be asked).

   Functional Scope & Behavior:
   - Core user goals & success criteria
   - Explicit out-of-scope declarations
   - User roles / personas differentiation

   Domain & Data Model:
   - Entities, attributes, relationships
   - Identity & uniqueness rules
   - Lifecycle/state transitions
   - Data volume / scale assumptions

   Interaction & UX Flow:
   - Critical user journeys / sequences
   - Error/empty/loading states
   - Accessibility or localization notes

   Non-Functional Quality Attributes:
   - Performance (latency, throughput targets)
   - Scalability (horizontal/vertical, limits)
   - Reliability & availability (uptime, recovery expectations)
   - Observability (logging, metrics, tracing signals)
   - Security & privacy (authN/Z, data protection, threat assumptions)
   - Compliance / regulatory constraints (if any)

   Integration & External Dependencies:
   - External services/APIs and failure modes
   - Data import/export formats
   - Protocol/versioning assumptions

   Edge Cases & Failure Handling:
   - Negative scenarios
   - Rate limiting / throttling
   - Conflict resolution (e.g., concurrent edits)

   Constraints & Tradeoffs:
   - Technical constraints (language, storage, hosting)
   - Explicit tradeoffs or rejected alternatives

   Terminology & Consistency:
   - Canonical glossary terms
   - Avoided synonyms / deprecated terms

   Completion Signals:
   - Acceptance criteria testability
   - Measurable Definition of Done style indicators

   Misc / Placeholders:
   - TODO markers / unresolved decisions
   - Ambiguous adjectives ("robust", "intuitive") lacking quantification

   For each category with Partial or Missing status, add a candidate question opportunity unless:
   - Clarification would not materially change implementation or validation strategy
   - Information is better deferred to planning phase (note internally)

3. Generate (internally) a prioritized queue of candidate clarification questions (maximum 5). Do NOT output them all at once. Apply these constraints:
    - Maximum of 10 total questions across the whole session.
    - Each question must be answerable with EITHER:
       - A short multiple‑choice selection (2–5 distinct, mutually exclusive options), OR
       - A one-word / short‑phrase answer (explicitly constrain: "Answer in <=5 words").
    - Only include questions whose answers materially impact architecture, data modeling, task decomposition, test design, UX behavior, operational readiness, or compliance validation.
    - Ensure category coverage balance: attempt to cover the highest impact unresolved categories first; avoid asking two low-impact questions when a single high-impact area (e.g., security posture) is unresolved.
    - Exclude questions already answered, trivial stylistic preferences, or plan-level execution details (unless blocking correctness).
    - Favor clarifications that reduce downstream rework risk or prevent misaligned acceptance tests.
    - If more than 5 categories remain unresolved, select the top 5 by (Impact * Uncertainty) heuristic.

4. Sequential questioning loop (interactive):
    - Present EXACTLY ONE question at a time.
    - For multiple‑choice questions:
       - **Analyze all options** and determine the **most suitable option** based on:
          - Best practices for the project type
          - Common patterns in similar implementations
          - Risk reduction (security, performance, maintainability)
          - Alignment with any explicit project goals or constraints visible in the intent
       - Present your **recommended option prominently** at the top with clear reasoning (1-2 sentences explaining why this is the best choice).
       - Format as: `**Recommended:** Option [X] - <reasoning>`
       - Then render all options as a Markdown table:

       | Option | Description |
       |--------|-------------|
       | A | <Option A description> |
       | B | <Option B description> |
       | C | <Option C description> (add D/E as needed up to 5) |
       | Short | Provide a different short answer (<=5 words) (Include only if free-form alternative is appropriate) |

       - After the table, add: `You can reply with the option letter (e.g., "A"), accept the recommendation by saying "yes" or "recommended", or provide your own short answer.`
    - For short‑answer style (no meaningful discrete options):
       - Provide your **suggested answer** based on best practices and context.
       - Format as: `**Suggested:** <your proposed answer> - <brief reasoning>`
       - Then output: `Format: Short answer (<=5 words). You can accept the suggestion by saying "yes" or "suggested", or provide your own answer.`
    - After the user answers:
       - If the user replies with "yes", "recommended", or "suggested", use your previously stated recommendation/suggestion as the answer.
       - Otherwise, validate the answer maps to one option or fits the <=5 word constraint.
       - If ambiguous, ask for a quick disambiguation (count still belongs to same question; do not advance).
       - Once satisfactory, record it in working memory (do not yet write to disk) and move to the next queued question.
    - Stop asking further questions when:
       - All critical ambiguities resolved early (remaining queued items become unnecessary), OR
       - User signals completion ("done", "good", "no more"), OR
       - You reach 5 asked questions.
    - Never reveal future queued questions in advance.
    - If no valid questions exist at start, immediately report no critical ambiguities.

5. Integration after EACH accepted answer (incremental update approach):
    - Maintain in-memory representation of the intent (loaded once at start) plus the raw file contents.
    - For the first integrated answer in this session:
       - Ensure a `## Clarifications` section exists (create it just after the highest-level contextual/overview section per the intent template if missing).
       - Under it, create (if not present) a `### Session YYYY-MM-DD` subheading for today.
    - Append a bullet line immediately after acceptance: `- Q: <question> → A: <final answer>`.
    - Then immediately apply the clarification to the most appropriate section(s):
       - Functional ambiguity → Update or add a bullet in Functional Requirements.
       - User interaction / actor distinction → Update User Stories or Actors subsection (if present) with clarified role, constraint, or scenario.
       - Data shape / entities → Update Data Model (add fields, types, relationships) preserving ordering; note added constraints succinctly.
       - Non-functional constraint → Add/modify measurable criteria in Non-Functional / Quality Attributes section (convert vague adjective to metric or explicit target).
       - Edge case / negative flow → Add a new bullet under Edge Cases / Error Handling (or create such subsection if template provides placeholder for it).
       - Terminology conflict → Normalize term across intent; retain original only if necessary by adding `(formerly referred to as "X")` once.
    - If the clarification invalidates an earlier ambiguous statement, replace that statement instead of duplicating; leave no obsolete contradictory text.
    - Save the intent file AFTER each integration to minimize risk of context loss (atomic overwrite).
    - Preserve formatting: do not reorder unrelated sections; keep heading hierarchy intact.
    - Keep each inserted clarification minimal and testable (avoid narrative drift).

6. Validation (performed after EACH write plus final pass):
   - Clarifications session contains exactly one bullet per accepted answer (no duplicates).
   - Total asked (accepted) questions ≤ 5.
   - Updated sections contain no lingering vague placeholders the new answer was meant to resolve.
   - No contradictory earlier statement remains (scan for now-invalid alternative choices removed).
   - Markdown structure valid; only allowed new headings: `## Clarifications`, `### Session YYYY-MM-DD`.
   - Terminology consistency: same canonical term used across all updated sections.

   **Intent Quality Validation** (after all clarifications integrated):
   - All clarifications are integrated into appropriate sections (not just in Clarifications section)
   - No placeholder text or TODO markers remain from clarifications
   - Updated sections maintain intent.md template structure
   - Requirements remain testable and unambiguous
   - Success criteria remain measurable
   - If validation fails: Fix intent.md structure and content before reporting completion

7. Write the updated intent back to `FEATURE_SPEC`.

8. Report completion (after questioning loop ends or early termination):
   - Number of questions asked & answered.
   - Path to updated intent.
   - Sections touched (list names).
   - Coverage summary table listing each taxonomy category with Status: Resolved (was Partial/Missing and addressed), Deferred (exceeds question quota or better suited for planning), Clear (already sufficient), Outstanding (still Partial/Missing but low impact).
   - If any Outstanding or Deferred remain, recommend whether to proceed to `/intent.plan` or run `/intent.clarify` again later post-plan.
   - Suggested next command.

Behavior rules:

- If no meaningful ambiguities found (or all potential questions would be low-impact), respond: "No critical ambiguities detected worth formal clarification." and suggest proceeding.
- If intent intent file missing, instruct user to run `/intent.capture` first (do not create a new intent intent here).
- Never exceed 5 total asked questions (clarification retries for a single question do not count as new questions).
- Avoid speculative tech stack questions unless the absence blocks functional clarity.
- Respect user early termination signals ("stop", "done", "proceed").
- If no questions asked due to full coverage, output a compact coverage summary (all categories Clear) then suggest advancing.
- If quota reached with unresolved high-impact categories remaining, explicitly flag them under Deferred with rationale.

## Validation and Repair Stage

**After clarification integration, execute validation/repair loop:**

1. **Validate Content Quality**: Execute `{VALIDATE_SCRIPT} --file FEATURE_SPEC --content-type intent`
   - If validation passes (`status: pass`), proceed to run report generation
   - If validation fails (`status: fail`), continue to repair step

2. **Repair Content (if needed)**: Execute `{REPAIR_SCRIPT} --file FEATURE_SPEC --content-type intent` 
   - Re-validate the repaired content
   - If re-validation passes, proceed to run report generation
   - If re-validation fails, document issues and proceed to run report with `status: repaired`

3. **Update Run Report Values**: Adjust run report parameters based on validation/repair outcome:
   - **validator_pass_rate**: From validation report
   - **status**: `pass` (if validation passed without repair), `repaired` (if repair was needed)
   - **retries**: Number of repair iterations performed
   - **score**: Quality score based on validation results

## Run Report Generation

**Upon completion of clarification, generate and save run report:**

- **Create run_report.json**: After all clarifications are integrated and intent file is updated
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

**Track clarification metrics to calculate Intent Kit Reliability Index:**

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

Context for prioritization: {ARGS}
