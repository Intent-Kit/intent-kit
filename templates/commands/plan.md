---
description: Execute the implementation planning workflow following intent methodology's shaping and injection stages to generate design artifacts.
scripts:
  sh: scripts/bash/setup-plan.sh --json
  ps: scripts/powershell/setup-plan.ps1 -Json
agent_scripts:
  sh: scripts/bash/update-agent-context.sh __AGENT__
  ps: scripts/powershell/update-agent-context.ps1 -AgentType __AGENT__
---

## User Input

```text
$ARGUMENTS
```

You **MUST** consider the user input before proceeding (if not empty).

## Intent Methodology Application

**CRITICAL**: You MUST actively apply the intent methodology's operational model stages throughout this planning command. The methodology must guide your decisions, not just be mentioned.

**Required Methodology Execution:**

## **Stage 1: Shaping Stage (MUST PERFORM EXPLICITLY)**

Before generating any plan content, you MUST:

1. **Re-extract Intent Signals** from intent.md:
   - Re-read the intent to identify core motivation (impulse)
   - Extract updated signals (any changes from capture phase)
   - Normalize terminology consistency

2. **Weight Motives, Biases, and Modes**:
   - Analyze intent signals to determine implementation priority
   - If intent emphasizes scale/complexity → architect archetype
   - If intent emphasizes speed/rapid iteration → hacker archetype
   - If intent emphasizes quality/perfection → craftsman archetype
   - If intent emphasizes analysis/documentation → scholar archetype
   - If intent emphasizes simplicity/minimalism → zen_coder archetype
   - Document your archetype selection with reasoning

3. **Form Implementation Approach**:
   - Apply design archetype traits to all planning decisions
   - Architect: Think in systems, design for scale, structured modules
   - Hacker: Improvisational, boundary-pushing, speed-oriented
   - Craftsman: Perfectionist, aesthetic, detail-obsessed
   - Scholar: Analytical, documented, reason-driven
   - Zen_Coder: Minimalist, calm, clarity-driven
   - Document how archetype influenced your technical choices

## **Stage 2: Injection Stage (MUST PERFORM EXPLICITLY)**

While generating plan content, you MUST:

1. **Integrate Intent Context**:
   - Every technical decision must trace back to intent.md requirements
   - Every technology choice must align with user stories and success criteria
   - Document in your reasoning: How does this technology serve the intent?

2. **Apply Core Philosophy**:
   - **direction_over_description**: Focus on what the intent drives toward, not implementation details
   - **guided_agency**: Make informed technology choices based on intent, don't ask about reasonable defaults
   - **contextual_continuity**: Maintain consistent terminology from intent.md in plan.md
   - Document how each philosophy principle guided your decisions

3. **Apply Bias Principles**:
   - **Functional purity**: Prefer pure functions, minimal side effects
   - **Minimalist UX**: Choose simplest user interaction patterns
   - **Modular composition**: Structure as independent, composable modules
   - Document how biases influenced your architecture choices

## **Stage 3: Action Tendencies (MUST APPLY)**

Throughout plan generation, you MUST:

- Use verbose naming conventions (reflect in plan.md examples)
- Apply abstract-level commenting (not implementation details)
- Follow scenario-driven testing approach (tests reflect user scenarios)

**Validation Checkpoint**: Before completing plan.md, verify:

- [ ] Design archetype is explicitly selected and documented
- [ ] Every technical decision traces to intent.md
- [ ] Core philosophy (direction_over_description, guided_agency, contextual_continuity) is evident in decisions
- [ ] Bias principles influenced architecture choices
- [ ] Action tendencies are reflected in naming/conventions

## Outline

1. **Setup**: Run `{SCRIPT}` from repo root and parse JSON for FEATURE_SPEC, IMPL_PLAN, SPECS_DIR, BRANCH. For single quotes in args like "I'm Groot", use escape syntax: e.g 'I'\''m Groot' (or double-quote if possible: "I'm Groot").

2. **Load context**: Read FEATURE_SPEC and `/memory/constitution.md`. Load IMPL_PLAN template (already copied), applying injection stage to integrate intent context.

3. **Execute plan workflow**: Follow the structure in IMPL_PLAN template, applying shaping stage to weight motives and form implementation approach:
   - Fill Technical Context (mark unknowns as "NEEDS CLARIFICATION")
   - Fill Constitution Check section from constitution
   - Evaluate gates (ERROR if violations unjustified)
   - Phase 0: Generate research.md (resolve all NEEDS CLARIFICATION)
   - Phase 1: Generate data-model.md, contracts/, quickstart.md
   - Phase 1: Update agent context by running the agent script
   - Re-evaluate Constitution Check post-design

4. **Stop and report**: Command ends after Phase 2 planning. Report branch, IMPL_PLAN path, and generated artifacts.

## Phases

### Phase 0: Outline & Research

1. **Extract unknowns from Technical Context** above:
   - For each NEEDS CLARIFICATION → research task
   - For each dependency → best practices task
   - For each integration → patterns task

2. **Generate and dispatch research agents**:

   ```text
   For each unknown in Technical Context:
     Task: "Research {unknown} for {feature context}"
   For each technology choice:
     Task: "Find best practices for {tech} in {domain}"
   ```

3. **Consolidate findings** in `research.md` using format:
   - Decision: [what was chosen]
   - Rationale: [why chosen]
   - Alternatives considered: [what else evaluated]

4. **Research Quality Validation** (before marking research complete):
   - Every NEEDS CLARIFICATION marker must be resolved
   - Every decision must have clear rationale
   - Every alternative must be evaluated (not just listed)
   - Technical decisions must align with intent requirements
   - Decisions must be specific enough to guide implementation
   - If validation fails: Update research.md until all criteria pass

**Output**: research.md with all NEEDS CLARIFICATION resolved and validated

### Phase 1: Design & Contracts

**Prerequisites:** `research.md` complete

1. **Extract entities from feature intent** → `data-model.md`:
   - Entity name, fields, relationships
   - Validation rules from requirements
   - State transitions if applicable

2. **Generate API contracts** from functional requirements:
   - For each user action → endpoint
   - Use standard REST/GraphQL patterns
   - Output OpenAPI/GraphQL schema to `/contracts/`

3. **Design Artifact Quality Validation** (before marking Phase 1 complete):

   **Data Model Validation**:
   - Every entity from intent.md is represented in data-model.md
   - Every entity has required fields defined
   - Relationships between entities are documented
   - Validation rules match requirements from intent.md
   - State transitions (if any) are complete and valid
   - If validation fails: Update data-model.md

   **Contract Validation**:
   - Every functional requirement with user actions has corresponding contract
   - Every endpoint has complete specification (method, path, params, response)
   - Contracts follow consistent patterns (naming, structure, error responses)
   - Contracts match data model entities
   - OpenAPI/GraphQL schemas are syntactically correct
   - If validation fails: Update contracts

   **Quickstart Validation**:
   - Quickstart includes integration scenarios from intent.md
   - Scenarios are testable and specific
   - Scenarios cover primary user flows
   - If validation fails: Update quickstart.md

4. **Agent context update**:
   - Run `{AGENT_SCRIPT}`
   - These scripts detect which AI agent is in use
   - Update the appropriate agent-specific context file
   - Add only new technology from current plan
   - Preserve manual additions between markers

**Output**: data-model.md, /contracts/*, quickstart.md, agent-specific file (all validated)

## Key rules

- Use absolute paths
- ERROR on gate failures or unresolved clarifications
