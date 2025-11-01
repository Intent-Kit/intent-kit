---
description: Generate an actionable, dependency-ordered tasks.md for the intent based on available design artifacts, following modulation stage principles.
scripts:
  sh: scripts/bash/check-prerequisites.sh --json
  ps: scripts/powershell/check-prerequisites.ps1 -Json
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

**CRITICAL**: You MUST actively apply the intent methodology's modulation stage throughout task generation. The methodology must influence how you create and organize tasks.

**Required Modulation Stage Execution:**

**Before generating tasks, you MUST:**

1. **Re-apply Shaping Stage**:
   - Re-read intent.md and plan.md
   - Identify the design archetype selected in plan.md
   - Understand the implementation mode (hack_fast/refine/audit/polish)
   - Document: How should the selected archetype influence task breakdown?
     - **Architect**: Structure tasks for modular, scalable implementation
     - **Hacker**: Create tasks for rapid iteration and quick wins
     - **Craftsman**: Create tasks that allow for quality refinement
     - **Scholar**: Create tasks with clear research and documentation phases
     - **Zen_Coder**: Create minimal, essential tasks only

2. **Apply Modulation to Task Generation**:

   **Influence Task Breakdown**:
   - Apply archetype traits to how you decompose work
   - Architect: Group related functionality, think in interfaces
   - Hacker: Break into small, quick-to-complete tasks
   - Craftsman: Include refinement and polish tasks
   - Scholar: Include research and documentation tasks
   - Zen_Coder: Minimize task count, essential only

   **Influence Task Ordering**:
   - Apply core philosophy to ordering:
     - **direction_over_description**: Order tasks by user value, not technical dependencies alone
     - **guided_agency**: Order to enable early feedback and iteration
     - **contextual_continuity**: Order to maintain context between related tasks
   - Apply bias principles to ordering:
     - **Functional purity**: Order to enable pure function development
     - **Modular composition**: Order to build independent modules first
     - **Minimalist UX**: Order user-facing tasks early for feedback

   **Influence Task Descriptions**:
   - Apply action tendencies to descriptions:
     - **Verbose naming**: Use clear, descriptive task names
     - **Abstract commenting**: Describe WHAT and WHY in tasks, not HOW
     - **Scenario-driven**: Frame tasks in terms of user scenarios
   - Apply rules to descriptions:
     - **Simplicity**: Keep task descriptions simple and clear
     - **Readability**: Write descriptions that are easy to understand later
     - **Fail fast**: Order tasks to enable early validation

3. **Maintain Contextual Continuity**:
   - Use terminology from intent.md in task descriptions
   - Reference user stories from intent.md in tasks
   - Align task structure with plan.md architecture
   - Ensure tasks trace back to intent.md requirements

**Modulation Validation Checkpoint**:

Before completing tasks.md, verify:

- [ ] Task breakdown reflects the selected design archetype from plan.md
- [ ] Task ordering follows core philosophy (direction_over_description, guided_agency, contextual_continuity)
- [ ] Task descriptions use terminology from intent.md
- [ ] Tasks are framed in terms of user scenarios (scenario-driven)
- [ ] Task structure aligns with plan.md architecture (modular composition)
- [ ] Tasks enable early validation and iteration (fail fast)

## Outline

1. **Setup**: Run `{SCRIPT}` from repo root and parse FEATURE_DIR and AVAILABLE_DOCS list. All paths must be absolute. For single quotes in args like "I'm Groot", use escape syntax: e.g 'I'\''m Groot' (or double-quote if possible: "I'm Groot").

2. **Load design documents**: Read from FEATURE_DIR:
   - **Required**: plan.md (tech stack, libraries, structure), intent.md (user stories with priorities)
   - **Optional**: data-model.md (entities), contracts/ (API endpoints), research.md (decisions), quickstart.md (test scenarios)
   - Note: Not all projects have all documents. Generate tasks based on what's available.

3. **Execute task generation workflow**:
   - Load plan.md and extract tech stack, libraries, project structure
   - Load intent.md and extract user stories with their priorities (P1, P2, P3, etc.)
   - If data-model.md exists: Extract entities and map to user stories
   - If contracts/ exists: Map endpoints to user stories
   - If research.md exists: Extract decisions for setup tasks
   - Generate tasks organized by user story (see Task Generation Rules below)
   - Generate dependency graph showing user story completion order
   - Create parallel execution examples per user story
   - Validate task completeness (each user story has all needed tasks, independently testable)

4. **Generate tasks.md**: Use `.intent/templates/tasks-template.md` as structure, fill with:
   - Correct feature name from plan.md
   - Phase 1: Setup tasks (project initialization)
   - Phase 2: Foundational tasks (blocking prerequisites for all user stories)
   - Phase 3+: One phase per user story (in priority order from intent.md)
   - Each phase includes: story goal, independent test criteria, tests (if requested), implementation tasks
   - Final Phase: Polish & cross-cutting concerns
   - All tasks must follow the strict checklist format (see Task Generation Rules below)
   - Clear file paths for each task
   - Dependencies section showing story completion order
   - Parallel execution examples per story
   - Implementation strategy section (MVP first, incremental delivery)

5. **Task Quality Validation** (MANDATORY before reporting):

   **For each generated task, verify:**

   a. **Format Compliance**:
      - Every task MUST start with `- [ ]` (markdown checkbox)
      - Every task MUST have a Task ID (T001, T002, etc.)
      - Every task MUST have a description with exact file path
      - User story tasks MUST have [US#] label
      - Parallel tasks MUST have [P] marker
      - If ANY task fails format check: Fix immediately before proceeding

   b. **Completeness Verification**:
      - Every user story from intent.md has at least one corresponding task
      - Every functional requirement has at least one task mapped to it
      - Every entity from data-model.md (if exists) has at least one task
      - Every contract/endpoint from contracts/ (if exists) has at least one task
      - If requirements or entities are missing tasks: Add them before proceeding

   c. **Dependency Validation**:
      - All task dependencies are valid (referenced tasks exist)
      - Tasks are ordered correctly (prerequisites come before dependents)
      - Parallel tasks [P] truly have no dependencies on incomplete tasks
      - Phase ordering is logical (Setup before Foundational, Foundational before User Stories)
      - If dependencies invalid: Fix ordering before proceeding

   d. **Clarity Verification**:
      - Every task description is specific enough for an LLM to implement without additional context
      - Every task has a clear action verb (Create, Implement, Add, Configure, etc.)
      - Every task has exact file paths (no vague references like "appropriate file")
      - Task descriptions match what's needed to fulfill user stories
      - If tasks unclear: Rewrite descriptions to be more specific

   e. **Coverage Validation**:
      - Each user story phase is independently testable
      - Test criteria (if requested) are defined for each user story
      - All phases have required tasks (Setup, Core, Integration, etc.)
      - Polish phase includes cross-cutting concerns
      - If coverage incomplete: Add missing tasks

   f. **Consistency Check**:
      - Task IDs are sequential with no gaps or duplicates
      - Naming conventions are consistent across similar tasks
      - File paths follow project structure from plan.md
      - Task organization matches user story priorities from intent.md
      - If inconsistencies found: Fix to maintain consistency

   **CRITICAL**: If ANY validation step fails, fix the issues BEFORE reporting completion. Do NOT report successful generation if tasks have format errors, missing requirements, or invalid dependencies.

## Validation and Repair Stage

**After task generation and initial validation, execute systematic validation/repair loop:**

1. **Validate Content Quality**: Execute `{VALIDATE_SCRIPT} --file TASKS --content-type tasks`
   - If validation passes (`status: pass`), proceed to run report generation
   - If validation fails (`status: fail`), continue to repair step

2. **Repair Content (if needed)**: Execute `{REPAIR_SCRIPT} --file TASKS --content-type tasks` 
   - Re-validate the repaired content
   - If re-validation passes, proceed to run report generation
   - If re-validation fails, document issues and proceed to run report with `status: repaired`

3. **Update Run Report Values**: Adjust run report parameters based on validation/repair outcome:
   - **validator_pass_rate**: From validation report
   - **status**: `pass` (if validation passed without repair), `repaired` (if repair was needed)
   - **retries**: Number of repair iterations performed
   - **score**: Quality score based on validation results

6. **Report**: Output path to generated tasks.md and summary:
   - Total task count
   - Task count per user story
   - Parallel opportunities identified
   - Independent test criteria for each story
   - Suggested MVP scope (typically just User Story 1)
   - Format validation: Confirm ALL tasks follow the checklist format (checkbox, ID, labels, file paths)
   - Validation results: List any issues found and fixed during validation

Context for task generation: {ARGS}

The tasks.md should be immediately executable - each task must be specific enough that an LLM can complete it without additional context.

## Task Generation Rules

**CRITICAL**: Tasks MUST be organized by user story to enable independent implementation and testing.

**Tests are OPTIONAL**: Only generate test tasks if explicitly requested in the feature specification or if user requests TDD approach.

### Checklist Format (REQUIRED)

Every task MUST strictly follow this format:

```text
- [ ] [TaskID] [P?] [Story?] Description with file path
```

**Format Components**:

1. **Checkbox**: ALWAYS start with `- [ ]` (markdown checkbox)
2. **Task ID**: Sequential number (T001, T002, T003...) in execution order
3. **[P] marker**: Include ONLY if task is parallelizable (different files, no dependencies on incomplete tasks)
4. **[Story] label**: REQUIRED for user story phase tasks only
   - Format: [US1], [US2], [US3], etc. (maps to user stories from intent.md)
   - Setup phase: NO story label
   - Foundational phase: NO story label  
   - User Story phases: MUST have story label
   - Polish phase: NO story label
5. **Description**: Clear action with exact file path

**Examples**:

- ✅ CORRECT: `- [ ] T001 Create project structure per implementation plan`
- ✅ CORRECT: `- [ ] T005 [P] Implement authentication middleware in src/middleware/auth.py`
- ✅ CORRECT: `- [ ] T012 [P] [US1] Create User model in src/models/user.py`
- ✅ CORRECT: `- [ ] T014 [US1] Implement UserService in src/services/user_service.py`
- ❌ WRONG: `- [ ] Create User model` (missing ID and Story label)
- ❌ WRONG: `T001 [US1] Create model` (missing checkbox)
- ❌ WRONG: `- [ ] [US1] Create User model` (missing Task ID)
- ❌ WRONG: `- [ ] T001 [US1] Create model` (missing file path)

### Task Organization

1. **From User Stories (intent.md)** - PRIMARY ORGANIZATION:
   - Each user story (P1, P2, P3...) gets its own phase
   - Map all related components to their story:
     - Models needed for that story
     - Services needed for that story
     - Endpoints/UI needed for that story
     - If tests requested: Tests specific to that story
   - Mark story dependencies (most stories should be independent)

2. **From Contracts**:
   - Map each contract/endpoint → to the user story it serves
   - If tests requested: Each contract → contract test task [P] before implementation in that story's phase

3. **From Data Model**:
   - Map each entity to the user story(ies) that need it
   - If entity serves multiple stories: Put in earliest story or Setup phase
   - Relationships → service layer tasks in appropriate story phase

4. **From Setup/Infrastructure**:
   - Shared infrastructure → Setup phase (Phase 1)
   - Foundational/blocking tasks → Foundational phase (Phase 2)
   - Story-specific setup → within that story's phase

### Phase Structure

- **Phase 1**: Setup (project initialization)
- **Phase 2**: Foundational (blocking prerequisites - MUST complete before user stories)
- **Phase 3+**: User Stories in priority order (P1, P2, P3...)
  - Within each story: Tests (if requested) → Models → Services → Endpoints → Integration
  - Each phase should be a complete, independently testable increment
- **Final Phase**: Polish & Cross-Cutting Concerns

## Run Report Generation

**Upon completion of task generation, generate and save run report:**

- **Create run_report.json**: After tasks.md is validated and written
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

**Track task generation metrics to calculate Intent Kit Reliability Index:**

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
