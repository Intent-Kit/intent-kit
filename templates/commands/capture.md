---
description: Capture the core intent from a natural language feature description, following the intent methodology's impulse and extraction stages.
scripts:
  sh: scripts/bash/create-new-feature.sh --json "{ARGS}"
  ps: scripts/powershell/create-new-feature.ps1 -Json "{ARGS}"
---

## User Input

```text
$ARGUMENTS
```

You **MUST** consider the user input before proceeding (if not empty).

## Intent Methodology Application

**CRITICAL**: You MUST actively apply the intent methodology's operational model throughout this command. Do not merely mention the methodology—you must demonstrate its application at each stage.

**Required Operational Model Execution:**

1. **Impulse Stage** (MUST PERFORM):
   - Read the user input carefully
   - Identify the human motivation behind the request
   - Capture the emotional tone (urgency, excitement, concern, etc.)
   - Document in your reasoning: What is the user's underlying motivation? What tone does their request convey?
   - **Validation**: Can you articulate why the user wants this feature, not just what they want?

2. **Extraction Stage** (MUST PERFORM):
   - Parse the natural language into structured intent signals
   - Extract key concepts: actors (who), actions (what), objects (what things), constraints (when/where/why)
   - Normalize terminology (map synonyms to canonical terms)
   - Identify ambiguities explicitly
   - Document in your reasoning: What are the core intent signals? What concepts did you extract?
   - **Validation**: Have you converted the natural language into structured signals?

3. **Shaping Stage** (MUST PERFORM):
   - Weight the motives, biases, and modes based on the extracted signals
   - Select appropriate design archetype (architect/hacker/craftsman/scholar/zen_coder) based on intent characteristics
   - Determine implementation mode (hack_fast/refine/audit/polish) based on context
   - Document in your reasoning: Which archetype did you choose and why? What mode fits this intent?
   - **Validation**: Have you consciously weighted motives and selected an archetype?

4. **Injection Stage** (MUST PERFORM):
   - Integrate the intent context into all reasoning
   - Apply core philosophy: direction_over_description (focus on driving force, not static details)
   - Apply guided_agency (treat user as collaborator, make informed guesses where appropriate)
   - Apply contextual_continuity (maintain consistent context throughout)
   - Document in your reasoning: How did you apply each philosophy principle?
   - **Validation**: Is your reasoning driven by intent context, not generic patterns?

5. **Modulation Stage** (MUST PERFORM):
   - Influence micro-decisions during specification generation
   - Apply action tendencies: verbose naming, abstract commenting, scenario-driven thinking
   - Apply bias principles: functional purity, minimalist UX, modular composition
   - Apply rules: simplicity over cleverness, readability is longevity, fail fast refine later
   - Document in your reasoning: How did modulation influence your micro-decisions?
   - **Validation**: Are your decisions aligned with the selected archetype and biases?

## Outline

The text the user typed after `/intent.capture` in the triggering message **is** the intent description. Assume you always have it available in this conversation even if `{ARGS}` appears literally below. Do not ask the user to repeat it unless they provided an empty command.

**BEFORE proceeding with intent specification, you MUST execute the operational model stages above and document your methodology application.**

Given that intent description, apply the methodology by executing each stage:

### Step 1: Execute Impulse Stage

- Read the user's input text
- Identify: What is the user's underlying motivation? (Not what they asked for, but WHY they need it)
- Identify: What emotional tone does the request convey? (Urgent? Exciting? Frustrated? Exploratory?)
- Document your impulse findings before proceeding

### Step 2: Execute Extraction Stage

- Parse the natural language into structured signals:
  - Extract actors (who needs this)
  - Extract actions (what should happen)
  - Extract objects (what things are involved)
  - Extract constraints (when/where/why conditions)
- Normalize terminology (map "login" to "authentication", "user" to "actor", etc.)
- Identify explicit ambiguities
- Document your extraction findings (list extracted signals)

### Step 3: Execute Shaping Stage

- Analyze the extracted signals to determine:
  - **Design Archetype**: Choose architect (scale/complexity), hacker (speed/improvisation), craftsman (quality/perfection), scholar (analysis/documentation), or zen_coder (simplicity/minimalism)
  - **Implementation Mode**: Determine hack_fast (rapid prototyping), refine (iterative improvement), audit (careful analysis), or polish (perfection)
- Document your shaping decisions and reasoning

### Step 4: Execute Injection Stage

- Apply direction_over_description: Focus on the driving force, not implementation details
- Apply guided_agency: Make informed guesses based on context, don't ask about reasonable defaults
- Apply contextual_continuity: Maintain consistent terminology and concepts throughout
- Document how each philosophy principle influenced your approach

### Step 5: Execute Modulation Stage

- Apply action tendencies from your selected archetype
- Apply bias principles (functional purity, minimalist UX, modular composition)
- Apply rules (simplicity over cleverness, readability is longevity, fail fast refine later)
- Document how modulation influenced micro-decisions

**NOW proceed with intent generation:**

- **Extract core intent signals** and generate a concise short name (2-4 words) for the branch:
- Analyze the intent description and extract the most meaningful keywords following direction_over_description principle
- Create a 2-4 word short name that captures the essence of the intent
- Use action-noun format when possible (e.g., "add-user-auth", "fix-payment-bug")
- Preserve technical terms and acronyms (OAuth2, API, JWT, etc.)
- Keep it concise but descriptive enough to understand the intent at a glance
- Examples:
- "I want to add user authentication" → "user-auth"
- "Implement OAuth2 integration for the API" → "oauth2-api-integration"
      - "Create a dashboard for analytics" → "analytics-dashboard"
      - "Fix payment processing timeout bug" → "fix-payment-timeout"

- **Check for existing branches before creating new one**:

   a. First, fetch all remote branches to ensure we have the latest information:

   ```bash
      git fetch --all --prune
      ```

   b. Find the highest feature number across all sources for the short-name:
      - Remote branches: `git ls-remote --heads origin | grep -E 'refs/heads/[0-9]+-<short-name>$'`
      - Local branches: `git branch | grep -E '^[* ]*[0-9]+-<short-name>$'`
      - Intents directories: Check for directories matching `intents/[0-9]+-<short-name>`

   c. Determine the next available number:
      - Extract all numbers from all three sources
      - Find the highest number N
      - Use N+1 for the new branch number

   d. Run the script `{SCRIPT}` with the calculated number and short-name:
      - Pass `--number N+1` and `--short-name "your-short-name"` along with the feature description
      - Bash example: `{SCRIPT} --json --number 5 --short-name "user-auth" "Add user authentication"`
      - PowerShell example: `{SCRIPT} -Json -Number 5 -ShortName "user-auth" "Add user authentication"`

   **IMPORTANT**:
  - Check all three sources (remote branches, local branches, intents directories) to find the highest number
  - Only match branches/directories with the exact short-name pattern
  - If no existing branches/directories found with this short-name, start with number 1
  - You must only ever run this script once per feature
  - The JSON is provided in the terminal as output - always refer to it to get the actual content you're looking for
  - The JSON output will contain BRANCH_NAME and SPEC_FILE paths
  - For single quotes in args like "I'm Groot", use escape syntax: e.g 'I'\''m Groot' (or double-quote if possible: "I'm Groot")

- **Load `templates/intent-template.md` to understand required sections, applying shaping stage to weight motives and biases.**

- **Follow this execution flow**:

  - Parse intent description from Input (injection stage)
    - If empty: ERROR "No intent description provided"
  - Extract key concepts from description (modulation stage)
    - Identify: actors, actions, data, constraints
    - Apply design archetype based on intent (architect for scale, hacker for speed, etc.)
  - For unclear aspects:
  - Make informed guesses based on context and industry standards, following guided_agency principle
  - Only mark with [NEEDS CLARIFICATION: specific question] if:
    - The choice significantly impacts intent scope or user experience
    - Multiple reasonable interpretations exist with different implications
    - No reasonable default exists
  - **LIMIT: Maximum 3 [NEEDS CLARIFICATION] markers total**
  - Prioritize clarifications by impact: scope > security/privacy > user experience > technical details
  - Fill User Scenarios & Testing section
  - If no clear user flow: ERROR "Cannot determine user scenarios"
  - Generate Functional Requirements
  - Each requirement must be testable, emphasizing simplicity_over_cleverness
  - Use reasonable defaults for unspecified details (document assumptions in Assumptions section)
  - Define Success Criteria
  - Create measurable, technology-agnostic outcomes
  - Include both quantitative metrics (time, performance, volume) and qualitative measures (user satisfaction, task completion)
  - Each criterion must be verifiable without implementation details
  - Identify Key Entities (if data involved)
  - Return: SUCCESS (intent ready for planning)

- **Write the intent specification to SPEC_FILE using the template structure, replacing placeholders with concrete details derived from the intent description (arguments) while preserving section order and headings, following contextual_continuity principle.**

- **Intent Specification Quality Validation**: After writing the initial intent intent, validate it against quality criteria:

   a. **Create Intent Quality Checklist**: Generate a checklist file at `FEATURE_DIR/checklists/requirements.md` using the checklist template structure with these validation items:

```markdown
      # Specification Quality Checklist: [FEATURE NAME]
      
      **Purpose**: Validate specification completeness and quality before proceeding to planning
      **Created**: [DATE]
      **Feature**: [Link to intent.md]
      
      ## Content Quality
      
      - [ ] No implementation details (languages, frameworks, APIs)
      - [ ] Focused on user value and business needs
      - [ ] Written for non-technical stakeholders
      - [ ] All mandatory sections completed
      
      ## Requirement Completeness
      
      - [ ] No [NEEDS CLARIFICATION] markers remain
      - [ ] Requirements are testable and unambiguous
      - [ ] Success criteria are measurable
      - [ ] Success criteria are technology-agnostic (no implementation details)
      - [ ] All acceptance scenarios are defined
      - [ ] Edge cases are identified
      - [ ] Scope is clearly bounded
      - [ ] Dependencies and assumptions identified
      
      ## Feature Readiness
      
      - [ ] All functional requirements have clear acceptance criteria
      - [ ] User scenarios cover primary flows
      - [ ] Feature meets measurable outcomes defined in Success Criteria
      - [ ] No implementation details leak into specification
      
      ## Notes
      
      - Items marked incomplete require intent updates before `/intent.clarify` or `/intent.plan`
```

   b. **Run Validation Check**: Review the intent against each checklist item:
      - For each item, determine if it passes or fails
      - Document specific issues found (quote relevant intent sections)
      - Verify intent structure follows intent-template.md exactly
      - Verify all mandatory sections are present and complete
      - Verify no implementation details leak into specification sections
      - Verify requirements are testable and unambiguous
      - Verify success criteria are measurable and technology-agnostic

   c. **Handle Validation Results**:

   **If all items pass**: Mark checklist complete and proceed to step 6

- **If items fail (excluding [NEEDS CLARIFICATION])**:
  - List the failing items and specific issues
  - Update the intent to address each issue
  - Re-run validation until all items pass (max 3 iterations)
  - If still failing after 3 iterations, document remaining issues in checklist notes and warn user

- **If [NEEDS CLARIFICATION] markers remain**:
        1. Extract all [NEEDS CLARIFICATION: ...] markers from the intent
        2. **LIMIT CHECK**: If more than 3 markers exist, keep only the 3 most critical (by scope/security/UX impact) and make informed guesses for the rest
        3. For each clarification needed (max 3), present options to user in this format:

```markdown
           ## Question [N]: [Topic]
           
           **Context**: [Quote relevant intent section]
           
           **What we need to know**: [Specific question from NEEDS CLARIFICATION marker]
           
           **Suggested Answers**:
           
           | Option | Answer | Implications |
           |--------|--------|--------------|
           | A      | [First suggested answer] | [What this means for the feature] |
           | B      | [Second suggested answer] | [What this means for the feature] |
           | C      | [Third suggested answer] | [What this means for the feature] |
           | Custom | Provide your own answer | [Explain how to provide custom input] |
           
           **Your choice**: _[Wait for user response]_
           ```

        4. **CRITICAL - Table Formatting**: Ensure markdown tables are properly formatted:
           - Use consistent spacing with pipes aligned
           - Each cell should have spaces around content: `| Content |` not `|Content|`
           - Header separator must have at least 3 dashes: `|--------|`
           - Test that the table renders correctly in markdown preview
        5. Number questions sequentially (Q1, Q2, Q3 - max 3 total)
        6. Present all questions together before waiting for responses
        7. Wait for user to respond with their choices for all questions (e.g., "Q1: A, Q2: Custom - [details], Q3: B")
        8. Update the intent by replacing each [NEEDS CLARIFICATION] marker with the user's selected or provided answer
        9. Re-run validation after all clarifications are resolved

   d. **Update Checklist**: After each validation iteration, update the checklist file with current pass/fail status

e. Report completion with branch name, intent file path, checklist results, and readiness for the next phase (`/intent.clarify` or `/intent.plan`).

**NOTE:** The script creates and checks out the new branch and initializes the intent intent file before writing.

## General Guidelines

## Quick Guidelines

- Focus on **DIRECTION** and **MOTIVE** following intent methodology's core philosophy
- Apply guided_agency: Treat AI as collaborator with shared intent
- Maintain contextual_continuity across sessions
- Avoid static descriptions; emphasize driving force over implementation details
- Written for intent capture, not technical implementation
- DO NOT create any checklists that are embedded in the intent intent. That will be a separate command.


### Section Requirements

- **Mandatory sections**: Must be completed for every intent capture
- **Optional sections**: Include only when relevant to the intent
- When a section doesn't apply, remove it entirely (don't leave as "N/A")


### For AI Generation (Intent Methodology Integration)

When capturing intent from a user prompt:

- **Apply operational model**: Follow impulse → extraction → shaping → injection → modulation
- **Select design archetype**: Choose architect/hacker/craftsman/scholar/zen_coder based on intent signals
- **Apply action tendencies**: Use verbose naming, abstract-level commenting, scenario-driven testing, as-you-go refactoring
- **Follow bias principles**: Functional purity reasoning, minimalist UX design, modular composition architecture
- **Adhere to rules**: Simplicity over cleverness, readability is longevity, fail fast refine later
- **Make informed guesses**: Use context, industry standards, and common patterns to fill gaps, following guided_agency
- **Document assumptions**: Record reasonable defaults in the Assumptions section
- **Limit clarifications**: Maximum 3 [NEEDS CLARIFICATION] markers - use only for critical decisions that:

  - Significantly impact intent scope or user experience
  - Have multiple reasonable interpretations with different implications
  - Lack any reasonable default


- **Prioritize clarifications**: scope > security/privacy > user experience > technical details
- **Think like intent validator**: Every vague intent should fail the "testable and unambiguous" checklist item
- **Common areas needing clarification** (only if no reasonable default exists):
  - Intent scope and boundaries (include/exclude specific use cases)
  - User types and permissions (if multiple conflicting interpretations possible)
  - Security/compliance requirements (when legally/financially significant)

**Examples of reasonable defaults** (don't ask about these):

- Data retention: Industry-standard practices for the domain
- Performance targets: Standard web/mobile app expectations unless specified
- Error handling: User-friendly messages with appropriate fallbacks
- Authentication method: Standard session-based or OAuth2 for web apps
- Integration patterns: RESTful APIs unless specified otherwise


### Success Criteria Guidelines

Success criteria must be:

- **Measurable**: Include specific metrics (time, percentage, count, rate)
- **Technology-agnostic**: No mention of frameworks, languages, databases, or tools
- **Intent-focused**: Describe outcomes from user/business perspective, aligned with motive and principle layers
- **Verifiable**: Can be tested/validated without knowing implementation details

**Good examples**:

- "Users can complete checkout in under 3 minutes"
- "System supports 10,000 concurrent users"
- "95% of searches return results in under 1 second"
- "Task completion rate improves by 40%"

**Bad examples** (implementation-focused):

- "API response time is under 200ms" (too technical, use "Users see results instantly")
- "Database can handle 1000 TPS" (implementation detail, use intent-facing metric)
- "React components render efficiently" (framework-specific)
- "Redis cache hit rate above 80%" (technology-specific)
