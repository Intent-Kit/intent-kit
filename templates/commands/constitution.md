---
description: Establish the project constitution following intent methodology's motive and principle layers, ensuring contextual_continuity across all development activities
---

## User Input

```text
$ARGUMENTS
```

You **MUST** consider the user input before proceeding (if not empty).

## Intent Methodology Application

Following the intent methodology's layers for constitution establishment:

**Motive Layer:**

- Define the driving force: Why this developer/project exists
- Example: "Empower indie devs to ship faster without losing soul"

**Principle Layer:**

- Establish governing rules for consistent decision-making
- Rules: Simplicity over cleverness, readability is longevity, fail fast refine later

**Contextual Continuity:**

- Ensure constitution provides persistent cognitive stance across sessions
- Guide all subsequent development phases (intent, plan, tasks, implement)

## Outline

You are updating the project constitution at `/memory/constitution.md`. This file is a TEMPLATE containing placeholder tokens in square brackets (e.g. `[PROJECT_NAME]`, `[PRINCIPLE_1_NAME]`). Your job is to (a) collect/derive concrete values, (b) fill the template precisely by replacing all placeholders, and (c) validate consistency with dependent artifacts (DO NOT modify template files - they are read-only).

Follow this execution flow, applying intent methodology layers:

1. **Motive Establishment**: Load the existing constitution template at `/memory/constitution.md` and identify the project's driving force.
   - Identify every placeholder token of the form `[ALL_CAPS_IDENTIFIER]`, focusing on motive-related tokens first.
   **IMPORTANT**: The user might require less or more principles than the ones used in the template. If a number is specified, respect that - follow the general template. You will update the doc accordingly.

2. **Principle Definition**: Collect/derive values for placeholders, establishing governing rules.
   - If user input (conversation) supplies a value, use it, following guided_agency principle.
   - Otherwise infer from existing repo context (README, docs, prior constitution versions if embedded).
   - For governance dates: `RATIFICATION_DATE` is the original adoption date (if unknown ask or mark TODO), `LAST_AMENDED_DATE` is today if changes are made, otherwise keep previous.
   - `CONSTITUTION_VERSION` must increment according to semantic versioning rules:
     - MAJOR: Backward incompatible governance/principle removals or redefinitions.
     - MINOR: New principle/section added or materially expanded guidance.
     - PATCH: Clarifications, wording, typo fixes, non-semantic refinements.
   - If version bump type ambiguous, propose reasoning before finalizing.

3. **Contextual Continuity Establishment**: Draft the updated constitution content to ensure persistent cognitive stance:
   - Replace every placeholder with concrete text (no bracketed tokens left except intentionally retained template slots that the project has chosen not to define yet—explicitly justify any left), following direction_over_description principle.
   - Preserve heading hierarchy and comments can be removed once replaced unless they still add clarifying guidance.
   - Ensure each Principle section: succinct name line, paragraph (or bullet list) capturing non‑negotiable rules, explicit rationale if not obvious.
   - Ensure Governance section lists amendment procedure, versioning policy, and compliance review expectations.

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

6. Validation before final output:
   - No remaining unexplained bracket tokens.
   - Version line matches report.
   - Dates ISO format YYYY-MM-DD.
   - Principles are declarative, testable, and free of vague language ("should" → replace with MUST/SHOULD rationale where appropriate).

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
