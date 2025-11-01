---
description: Execute the implementation plan by processing and executing all tasks defined in tasks.md, applying full intent methodology integration
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

**CRITICAL**: You MUST actively apply the complete intent methodology operational model throughout ALL implementation tasks. The methodology must drive your coding decisions, not just be referenced.

**Required Operational Model Re-application (Per Task):**

**Before starting EACH task, you MUST:**

1. **Impulse Stage Re-application**:
   - Re-read the task description and connect it to the original intent motivation
   - Ask: Why does this task exist? What user need does it serve?
   - Maintain connection to the human motivation behind the feature
   - **Validation**: Can you explain why this task matters to the user?

2. **Extraction Stage Re-application**:
   - Extract task-specific intent signals: What exactly must be implemented?
   - Parse task requirements into structured signals (inputs, outputs, behavior)
   - Identify task-specific constraints and edge cases
   - **Validation**: Have you structured the task requirements clearly?

3. **Shaping Stage Re-application**:
   - Re-read plan.md to identify the design archetype selected
   - Apply archetype traits to THIS specific task:
     - **Architect**: Structure for scale, think in modules, design interfaces
     - **Hacker**: Move fast, prototype quickly, iterate rapidly
     - **Craftsman**: Perfect implementation, elegant code, attention to detail
     - **Scholar**: Document thoroughly, analyze edge cases, justify decisions
     - **Zen_Coder**: Minimal code, maximum clarity, eliminate unnecessary complexity
   - **Validation**: Is your implementation approach aligned with the selected archetype?

4. **Injection Stage Re-application**:
   - Re-read intent.md and plan.md before implementing
   - Integrate intent context: How does this code serve the user stories?
   - Apply core philosophy to coding decisions:
     - **direction_over_description**: Focus on what the code achieves, not how it does it initially
     - **guided_agency**: Make informed implementation choices, don't ask about obvious defaults
     - **contextual_continuity**: Use terminology and patterns consistent with intent.md and plan.md
   - **Validation**: Does your code directly serve the intent requirements?

5. **Modulation Stage Re-application** (During Implementation):
   - Apply action tendencies while coding:
     - **Verbose naming**: Use descriptive variable/function names (reflect archetype style)
     - **Abstract commenting**: Comment on WHY and WHAT, not line-by-line HOW
     - **Scenario-driven testing**: Think about user scenarios, not just unit tests
     - **As-you-go refactoring**: Improve code quality incrementally
   - Apply bias principles while coding:
     - **Functional purity**: Prefer pure functions, minimize side effects
     - **Minimalist UX**: Choose simplest user interaction patterns
     - **Modular composition**: Structure as independent, composable modules
   - Apply rules while coding:
     - **Simplicity over cleverness**: Choose simple solution over clever one
     - **Readability is longevity**: Write code that's easy to understand
     - **Fail fast refine later**: Get it working first, then improve
   - **Validation**: Are naming, structure, and patterns aligned with methodology?

**Methodology Validation Checkpoint (After Each Task):**

Before marking any task [X], verify:

- [ ] Code serves the intent.md user stories (impulse connection maintained)
- [ ] Implementation follows plan.md archetype approach (shaping applied)
- [ ] Code uses terminology from intent.md (contextual_continuity applied)
- [ ] Decisions align with core philosophy (direction_over_description, guided_agency)
- [ ] Code structure reflects bias principles (functional purity, modular composition, minimalist UX)
- [ ] Naming follows action tendencies (verbose, reflects archetype)
- [ ] Code follows rules (simplicity, readability, fail fast)

**Methodology-Driven Code Review**:

When reviewing your generated code, explicitly check:

- Does this code embody the selected design archetype?
- Does this code directly serve the intent.md user stories?
- Does this code follow the plan.md architectural approach?
- Are naming conventions aligned with action tendencies?
- Does this code reflect the bias principles?
- Would someone reading this code understand the intent behind it?

## Code Quality Requirements

**CRITICAL**: All code must pass validation checks before tasks are marked complete. Buggy code is unacceptable. The following quality gates are mandatory:

1. **No Syntax Errors**: All code must compile/parse correctly for the target language
2. **Requirement Compliance**: Code must implement ALL requirements in the task description
3. **Logic Correctness**: Code must handle edge cases, errors, and edge conditions
4. **Integration Safety**: New code must not break existing functionality
5. **Code Review**: Every task must be self-reviewed before marking complete

**Common Bug Patterns to Avoid:**

- Missing null/undefined checks before accessing properties or calling methods
- Variables used before initialization or out of scope
- Missing error handling for API calls, file operations, database queries, network requests
- Off-by-one errors in loops or array access (especially with 0-indexed vs 1-indexed)
- Missing return statements or incorrect return values (wrong type, wrong format)
- Incorrect file paths or import paths (case sensitivity, relative vs absolute paths)
- Missing dependencies in package.json/requirements.txt/etc. or wrong versions
- Hardcoded values that should be configurable (URLs, credentials, magic numbers)
- Missing validation for user input or external data (sanitization, type checking)
- Infinite loops or recursion without termination conditions
- Resource leaks (unclosed files, connections, timers, event listeners)
- Race conditions (async operations without proper synchronization)
- Type mismatches (passing wrong types to functions, incorrect type conversions)
- State inconsistencies (variables modified but state not updated properly)
- Missing error propagation (swallowing errors instead of handling/raising)
- Incorrect conditional logic (AND vs OR, negation errors, boundary conditions)
- Missing input validation (empty strings, negative numbers, overflow values)
- API contract violations (wrong parameters, missing required fields, type mismatches)

## Outline

1. Run `{SCRIPT}` from repo root and parse FEATURE_DIR and AVAILABLE_DOCS list. All paths must be absolute. For single quotes in args like "I'm Groot", use escape syntax: e.g 'I'\''m Groot' (or double-quote if possible: "I'm Groot").

2. **Check checklists status** (if FEATURE_DIR/checklists/ exists):
   - Scan all checklist files in the checklists/ directory
   - For each checklist, count:
     - Total items: All lines matching `- [ ]` or `- [X]` or `- [x]`
     - Completed items: Lines matching `- [X]` or `- [x]`
     - Incomplete items: Lines matching `- [ ]`
   - Create a status table:

     ```text
     | Checklist | Total | Completed | Incomplete | Status |
     |-----------|-------|-----------|------------|--------|
     | ux.md     | 12    | 12        | 0          | ✓ PASS |
     | test.md   | 8     | 5         | 3          | ✗ FAIL |
     | security.md | 6   | 6         | 0          | ✓ PASS |
     ```

   - Calculate overall status:
     - **PASS**: All checklists have 0 incomplete items
     - **FAIL**: One or more checklists have incomplete items

   - **If any checklist is incomplete**:
     - Display the table with incomplete item counts
     - **STOP** and ask: "Some checklists are incomplete. Do you want to proceed with implementation anyway? (yes/no)"
     - Wait for user response before continuing
     - If user says "no" or "wait" or "stop", halt execution
     - If user says "yes" or "proceed" or "continue", proceed to step 3

   - **If all checklists are complete**:
     - Display the table showing all checklists passed
     - Automatically proceed to step 3

3. Load and analyze the implementation context:
   - **REQUIRED**: Read tasks.md for the complete task list and execution plan
   - **REQUIRED**: Read plan.md for tech stack, architecture, and file structure
   - **IF EXISTS**: Read data-model.md for entities and relationships
   - **IF EXISTS**: Read contracts/ for API specifications and test requirements
   - **IF EXISTS**: Read research.md for technical decisions and constraints
   - **IF EXISTS**: Read quickstart.md for integration scenarios

4. **Project Setup Verification**:
   - **REQUIRED**: Create/verify ignore files based on actual project setup:

   **Detection & Creation Logic**:
   - Check if the following command succeeds to determine if the repository is a git repo (create/verify .gitignore if so):

     ```sh
     git rev-parse --git-dir 2>/dev/null
     ```

   - Check if Dockerfile* exists or Docker in plan.md → create/verify .dockerignore
   - Check if .eslintrc*or eslint.config.* exists → create/verify .eslintignore
   - Check if .prettierrc* exists → create/verify .prettierignore
   - Check if .npmrc or package.json exists → create/verify .npmignore (if publishing)
   - Check if terraform files (*.tf) exist → create/verify .terraformignore
   - Check if .helmignore needed (helm charts present) → create/verify .helmignore

   **If ignore file already exists**: Verify it contains essential patterns, append missing critical patterns only
   **If ignore file missing**: Create with full pattern set for detected technology

   **Common Patterns by Technology** (from plan.md tech stack):
   - **Node.js/JavaScript/TypeScript**: `node_modules/`, `dist/`, `build/`, `*.log`, `.env*`
   - **Python**: `__pycache__/`, `*.pyc`, `.venv/`, `venv/`, `dist/`, `*.egg-info/`
   - **Java**: `target/`, `*.class`, `*.jar`, `.gradle/`, `build/`
   - **C#/.NET**: `bin/`, `obj/`, `*.user`, `*.suo`, `packages/`
   - **Go**: `*.exe`, `*.test`, `vendor/`, `*.out`
   - **Ruby**: `.bundle/`, `log/`, `tmp/`, `*.gem`, `vendor/bundle/`
   - **PHP**: `vendor/`, `*.log`, `*.cache`, `*.env`
   - **Rust**: `target/`, `debug/`, `release/`, `*.rs.bk`, `*.rlib`, `*.prof*`, `.idea/`, `*.log`, `.env*`
   - **Kotlin**: `build/`, `out/`, `.gradle/`, `.idea/`, `*.class`, `*.jar`, `*.iml`, `*.log`, `.env*`
   - **C++**: `build/`, `bin/`, `obj/`, `out/`, `*.o`, `*.so`, `*.a`, `*.exe`, `*.dll`, `.idea/`, `*.log`, `.env*`
   - **C**: `build/`, `bin/`, `obj/`, `out/`, `*.o`, `*.a`, `*.so`, `*.exe`, `Makefile`, `config.log`, `.idea/`, `*.log`, `.env*`
   - **Swift**: `.build/`, `DerivedData/`, `*.swiftpm/`, `Packages/`
   - **R**: `.Rproj.user/`, `.Rhistory`, `.RData`, `.Ruserdata`, `*.Rproj`, `packrat/`, `renv/`
   - **Universal**: `.DS_Store`, `Thumbs.db`, `*.tmp`, `*.swp`, `.vscode/`, `.idea/`

   **Tool-Specific Patterns**:
   - **Docker**: `node_modules/`, `.git/`, `Dockerfile*`, `.dockerignore`, `*.log*`, `.env*`, `coverage/`
   - **ESLint**: `node_modules/`, `dist/`, `build/`, `coverage/`, `*.min.js`
   - **Prettier**: `node_modules/`, `dist/`, `build/`, `coverage/`, `package-lock.json`, `yarn.lock`, `pnpm-lock.yaml`
   - **Terraform**: `.terraform/`, `*.tfstate*`, `*.tfvars`, `.terraform.lock.hcl`
   - **Kubernetes/k8s**: `*.secret.yaml`, `secrets/`, `.kube/`, `kubeconfig*`, `*.key`, `*.crt`

5. Parse tasks.md structure and extract:
   - **Task phases**: Setup, Tests, Core, Integration, Polish
   - **Task dependencies**: Sequential vs parallel execution rules
   - **Task details**: ID, description, file paths, parallel markers [P]
   - **Execution flow**: Order and dependency requirements

6. Execute implementation following the task plan:
   - **Phase-by-phase execution**: Complete each phase before moving to the next
   - **Respect dependencies**: Run sequential tasks in order, parallel tasks [P] can run together  
   - **Follow TDD approach**: Execute test tasks before their corresponding implementation tasks
   - **File-based coordination**: Tasks affecting the same files must run sequentially
   - **Validation checkpoints**: Verify each phase completion before proceeding

7. **Pre-Task Verification** (before starting any task):
   - **Read the task description carefully**: Understand exactly what needs to be implemented
   - **Check task dependencies**: Ensure all prerequisite tasks are marked complete [X]
   - **Review related files**: Read existing code that will be modified or extended
   - **Analyze existing code patterns**: Study how similar functionality is implemented in the codebase
   - **Match code style**: Note naming conventions, structure patterns, error handling approaches used in existing code
   - **Verify task scope**: Confirm the task matches the implementation plan and specification
   - **Identify potential issues**: Think through edge cases and error scenarios
   - **Check dependency versions**: Verify required dependencies are specified with compatible versions

8. **Task Implementation Rules**:

   **Code Generation Guidelines:**

   - **Read existing code first**: Before implementing, read similar code in the codebase to understand patterns
   - **Match existing patterns**: Follow the same structure, naming, and error handling as similar implementations
   - **Maintain context**: Keep in mind the overall feature context, related files, and dependencies while coding
   - **Generate complete implementations**: Don't leave TODOs or incomplete implementations unless explicitly requested
   - **Handle errors explicitly**: Every function should handle errors appropriately (not silently swallow them)

   **Common Implementation Patterns:**

   - **API endpoints**: Follow existing endpoint patterns (error responses, status codes, request/response formats)
   - **Database queries**: Use same query patterns, transaction handling, error handling as existing code
   - **File operations**: Follow same file reading/writing patterns, path handling, error handling
   - **Error handling**: Use same error types, messages, logging patterns as existing code
   - **Configuration**: Follow same config loading, validation, default value patterns
   - **Testing**: Use same test structure, assertions, setup/teardown patterns as existing tests

   **Execution Order**:

   - **Setup first**: Initialize project structure, dependencies, configuration
   - **Tests before code**: If you need to write tests for contracts, entities, and integration scenarios
   - **Core development**: Implement models, services, CLI commands, endpoints
   - **Integration work**: Database connections, middleware, logging, external services
   - **Polish and validation**: Unit tests, performance optimization, documentation

9. **Code Quality Validation** (MANDATORY before marking any task complete):

   **For each task, perform these checks in order:**

   a. **Syntax Validation**:
      - **Python**: Run `python -m py_compile <file>` or `python -m pyflakes <file>` if available
      - **JavaScript/TypeScript**: Run `node --check <file>` or `tsc --noEmit <file>` if TypeScript
      - **Go**: Run `go fmt <file>` and `go build ./...` if applicable
      - **Rust**: Run `cargo check` or `rustc --edition 2021 --crate-type bin <file>` if standalone
      - **Java**: Attempt compilation with `javac <file>` if classpath available
      - **C/C++**: Run syntax check with compiler flags `-fsyntax-only` or `-fsyntax-only -Wall`
      - **Other languages**: Use appropriate syntax checker or compiler if available
      - **If syntax errors found**: Fix immediately, do NOT proceed until syntax is valid

   b. **Code Review Against Task Requirements**:
      - Re-read the task description line-by-line
      - Verify code implements EVERY requirement mentioned in the task
      - Check that all file paths match what the task specifies
      - Confirm code follows the project structure defined in plan.md
      - Validate naming conventions match the project standards
      - Ensure no implementation details deviate from the task description

   c. **Static Analysis** (if tools available):
      - **Python**: Run `pylint`, `flake8`, or `mypy` if configured in project
      - **JavaScript/TypeScript**: Run `eslint` if `.eslintrc*` or `eslint.config.*` exists
      - **Go**: Run `go vet ./...` if applicable
      - **Rust**: Run `cargo clippy` if Cargo.toml exists
      - **Java**: Run linter if Maven/Gradle configured
      - **Address critical issues**: Fix errors, warnings can be noted but don't block if not critical

   d. **Logic Verification**:
      - Read through the code logic step-by-step as if seeing it for the first time
      - Trace execution paths: Follow each code path mentally to verify correctness
      - Verify error handling exists for failure cases (network failures, file I/O errors, validation failures, etc.)
      - Check that edge cases are handled (null checks, empty inputs, boundary conditions, overflow/underflow)
      - Confirm all variables are initialized before use (especially in loops or conditionals)
      - Ensure no obvious infinite loops or recursion without termination conditions
      - Validate that imported modules/packages are actually used (remove unused imports)
      - Check that function return values are properly handled (callers handle return values correctly)
      - Verify type consistency: Ensure variables maintain expected types throughout execution
      - Check resource cleanup: Verify files, connections, streams are closed/released properly
      - Validate state transitions: If state machines involved, verify all transitions are valid

   e. **Integration Checks**:
      - Verify code integrates with existing code correctly (imports, exports, interfaces match expected signatures)
      - Check API consistency: Similar functions should have consistent parameter patterns and return types
      - Verify interface contracts: Implementations match interface definitions exactly
      - Check that new code doesn't break existing functionality (no breaking changes to public APIs)
      - Validate that file structure matches project conventions
      - Confirm dependencies are correctly specified (package.json, requirements.txt, etc.) with compatible versions
      - Verify dependency installation: Check that dependencies can actually be installed/resolved
      - Check configuration consistency: New code follows same config patterns as existing code
      - Validate naming consistency: Functions/classes follow same naming patterns as similar code in codebase

   f. **Runtime Verification** (where feasible):
      - **Scripts/CLI tools**: Try running with `--help` or test basic execution if safe
      - **Functions/Classes**: Verify they can be imported/instantiated without errors
      - **Config files**: Validate syntax if JSON/YAML/TOML (use parser if available)
      - **Tests**: If test file created, attempt to run tests to verify they compile and at least pass basic cases
      - **APIs**: Verify endpoint definitions are syntactically correct
      - **Error messages**: Verify error messages are clear, actionable, and include context
      - **Skip runtime checks that could cause side effects**: Database writes, file deletions, network calls, destructive operations
      - **Dependency resolution**: If package.json/requirements.txt/etc. modified, verify dependencies can be resolved

   g. **Post-Implementation Review** (after all checks pass):
      - **Refactor if needed**: Review code for clarity, remove duplication, simplify complex logic
      - **Consistency check**: Ensure code follows same patterns as similar code in codebase
      - **Error message quality**: Verify error messages are user-friendly and include helpful context
      - **Documentation**: Add comments for complex logic, document non-obvious decisions
      - **Performance consideration**: Check for obvious performance issues (unnecessary loops, missing caching, etc.)

   **CRITICAL**: If ANY validation step fails, fix the issues BEFORE marking the task complete. Do NOT mark tasks [X] if code has syntax errors, missing requirements, or obvious bugs.

   **Iterative Refinement**: After passing all checks, take one more pass to refine the code:
   - Can any logic be simplified?
   - Are there any code smells (long functions, deep nesting, magic numbers)?
   - Is error handling comprehensive and consistent?
   - Would another developer understand this code easily?

10. **Self-Review Checklist** (verify before marking task [X]):

- [ ] Code has no syntax errors (validated with compiler/linter)
- [ ] All task requirements are implemented completely
- [ ] File paths match task specification exactly
- [ ] Error handling exists for all failure scenarios
- [ ] Edge cases are considered (null, empty, boundaries, overflow/underflow)
- [ ] Code follows project conventions (naming, structure, style) matching existing patterns
- [ ] Imports/dependencies are correct, necessary, and can be resolved
- [ ] Code is readable and maintainable (not overly clever, clear variable names)
- [ ] No obvious bugs or logic errors (traced through execution paths mentally)
- [ ] Integration with existing code is verified (APIs match, no breaking changes)
- [ ] Resource cleanup is handled (files closed, connections released, memory freed)
- [ ] Error messages are clear and actionable
- [ ] Code matches existing patterns in similar files
- [ ] Type consistency maintained throughout
- [ ] Unused code/imports removed

1. **Progress tracking and error handling**:

- Report progress after each completed task with validation results
- **Only mark task [X] after ALL validation checks pass**
- Halt execution if any non-parallel task fails validation
- For parallel tasks [P], continue with successful tasks, report failed ones
- Provide clear error messages with context for debugging
- If validation fails, clearly state which check failed and why
- Suggest specific fixes for validation failures
- **IMPORTANT**: Never mark a task [X] until it passes all validation checks

   **Context Management During Implementation**:

- **Maintain feature context**: Keep intent.md, plan.md, and tasks.md in mind while implementing
- **Track dependencies**: Remember which tasks depend on which, and verify dependencies before marking complete
- **Consistency across files**: When implementing related files, ensure they work together correctly
- **State management**: If implementing stateful features, verify state transitions are correct
- **API contracts**: If implementing APIs, verify they match contract specifications exactly

1. **Final Completion Validation** (before reporting completion):

- **Task Completeness Verification**:
  - Scan tasks.md and verify ALL tasks are marked [X]
  - Identify any incomplete tasks (marked [ ])
  - If tasks incomplete: Report list and DO NOT claim completion

- **Specification Alignment Check**:
  - Re-read intent.md and verify all functional requirements are implemented
  - Check that implemented features match the original specification exactly
  - Verify no features were added that weren't in the specification
  - Confirm no features were omitted from the specification

- **Quality Assurance Verification**:
  - Run project-wide syntax checks if possible (compile/build if configured)
  - Verify all test files are present if tests were requested
  - Attempt to run tests if test framework exists: `pytest`, `npm test`, `cargo test`, `go test`, etc.
  - Check test results and report failures (but don't block if tests not requested)
  - Validate that code follows project conventions consistently
  - Check for code smells: Long functions (>50 lines), deep nesting (>4 levels), high complexity
  - Verify error messages are consistent across similar functions/modules
  - Confirm no dead code or commented-out code blocks remain

- **Architecture Compliance**:
  - Verify implementation follows the technical plan (plan.md)
  - Check that file structure matches the plan.md Project Structure section
  - Confirm dependencies match what was specified in plan.md
  - Validate that design patterns match the chosen archetype (architect/hacker/craftsman/etc.)

- **Integration Verification**:
  - Verify all imports/dependencies are valid (no missing modules)
  - Check that configuration files are properly formatted
  - Confirm environment setup matches requirements
  - Validate that ignore files (.gitignore, etc.) are correctly configured

- **Documentation Check**:
  - Verify code has appropriate comments where complex logic exists
  - Check that function/class names are descriptive (verbose naming)
  - Confirm code is readable and maintainable

- **Final Report Generation**:
  - Summarize all completed tasks by phase
  - List any validation failures or warnings
  - Report test results if tests were run
  - Note any deviations from the original plan (if justified)
  - Provide next steps or recommendations
  - **Only claim completion if ALL validation checks pass**

## Validation and Repair Stage

**After implementation and initial validation, execute validation/repair loop:**

1. **Validate Content Quality**: Execute `{VALIDATE_SCRIPT}` on generated artifacts
   - If validation passes (`status: pass`), proceed to run report generation
   - If validation fails (`status: fail`), continue to repair step

2. **Repair Content (if needed)**: Execute `{REPAIR_SCRIPT}` on problematic artifacts
   - Re-validate the repaired content
   - If re-validation passes, proceed to run report generation
   - If re-validation fails, document issues and proceed to run report with `status: repaired`

3. **Update Run Report Values**: Adjust run report parameters based on validation/repair outcome:
   - **validator_pass_rate**: From validation report
   - **status**: `pass` (if validation passed without repair), `repaired` (if repair was needed)
   - **retries**: Number of repair iterations performed
   - **score**: Quality score based on validation results

**Run Report Generation**:
- **Create run_report.json**: After implementation is complete and all validation checks pass
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

**Track implementation metrics to calculate Intent Kit Reliability Index:**

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

Note: This command assumes a complete task breakdown exists in tasks.md. If tasks are incomplete or missing, suggest running `/intent.tasks` first to regenerate the task list.
