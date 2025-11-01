# AGENTS.md

## Intent Methodology

```yaml
intent_methodology:
  version: 2.0
  description: >
    Defines the philosophy, directional layers, and behavioral stance
    that guide AI cognition and decision-making in code generation.
    Enhanced with quality gates, feedback loops, validation, and 
    context preservation mechanisms to prevent bugs and ensure quality.

  core_philosophy:
    - direction_over_description: "Define the driving force, not static instructions."
    - guided_agency: "Treat AI as a collaborator with shared intent."
    - contextual_continuity: "Maintain persistent cognitive stance across sessions."

  layers:
    motive:
      purpose: "Why this developer or project exists."
      example: "Empower indie devs to ship faster without losing soul."
    principle:
      rules:
        - "Simplicity over cleverness."
        - "Readability is longevity."
        - "Fail fast, refine later."
    bias:
      reasoning_style: "Functional purity"
      design_bias: "Minimalist UX"
      architecture_bias: "Modular composition"
    mode:
      current: "Hack-Fast"
      available_modes:
        - hack_fast
        - refine
        - audit
        - polish
    action_tendency:
      naming: "Verbose"
      commenting: "Abstract-level guidance"
      testing: "Scenario-driven"
      refactoring: "As-you-go"

  design_archetypes:
    - name: architect
      traits:
        - systems_first
        - structured
        - precision_focused
      directive: "Design for scale. Think in modules."
    - name: hacker
      traits:
        - improvisational
        - boundary_pushing
        - speed_oriented
      directive: "Ignore convention if it blocks flow."
    - name: craftsman
      traits:
        - perfectionist
        - aesthetic
        - detail_obsessed
      directive: "Elegance before efficiency."
    - name: scholar
      traits:
        - analytical
        - documented
        - reason_driven
      directive: "Justify design decisions in-line."
    - name: zen_coder
      traits:
        - minimalist
        - calm
        - clarity_driven
      directive: "Eliminate everything unnecessary."

  operational_model:
    stages:
      - name: impulse
        description: "Capture human motivation or tone."
        quality_gates:
          - "Can articulate WHY the user wants this (not just WHAT)"
          - "Captured emotional tone or motivation (urgency, excitement, concern, etc.)"
          - "Identified underlying human need being addressed"
        anti_patterns:
          - "Focusing on WHAT instead of WHY"
          - "Ignoring emotional context or urgency signals"
          - "Jumping to technical solutions before understanding motivation"
        dependencies: []
        outputs: ["human_motivation", "emotional_tone", "driving_force"]
        
      - name: extraction
        description: "Parse and normalize intent signals into structured form."
        quality_gates:
          - "Extracted all key signals: actors (who), actions (what), objects (what things), constraints (when/where/why)"
          - "Normalized terminology (synonyms mapped to canonical terms)"
          - "Identified explicit ambiguities (not guessed)"
        anti_patterns:
          - "Guessing ambiguous requirements instead of marking them"
          - "Missing key signals (actors, actions, objects, constraints)"
          - "Inconsistent terminology (same concept named differently)"
        dependencies: ["impulse"]
        outputs: ["structured_signals", "normalized_terminology", "ambiguity_markers"]
        
      - name: shaping
        description: "Weight and merge motives, biases, and modes to form implementation approach."
        quality_gates:
          - "Selected design archetype based on intent signals (architect/hacker/craftsman/scholar/zen_coder)"
          - "Determined implementation mode (hack_fast/refine/audit/polish)"
          - "Documented archetype selection reasoning"
        anti_patterns:
          - "Selecting archetype without analyzing intent signals"
          - "Using wrong archetype for intent characteristics (e.g., hacker for complex system)"
          - "Not documenting archetype selection reasoning"
        dependencies: ["impulse", "extraction"]
        outputs: ["design_archetype", "implementation_mode", "shaping_rationale"]
        
      - name: injection
        description: "Integrate intent context into AI reasoning and decision-making."
        quality_gates:
          - "Applied direction_over_description (focus on driving force, not implementation details)"
          - "Applied guided_agency (made informed choices, didn't over-ask)"
          - "Applied contextual_continuity (maintained consistent terminology and concepts)"
        anti_patterns:
          - "Focusing on implementation details instead of driving force"
          - "Asking about obvious defaults instead of making informed choices"
          - "Using inconsistent terminology across artifacts"
        dependencies: ["impulse", "extraction", "shaping"]
        outputs: ["integrated_context", "philosophy_applied", "consistent_terminology"]
        
      - name: modulation
        description: "Influence micro-decisions during generation based on methodology principles."
        quality_gates:
          - "Applied action tendencies (verbose naming, abstract commenting, scenario-driven testing)"
          - "Applied bias principles (functional purity, minimalist UX, modular composition)"
          - "Applied rules (simplicity, readability, fail fast)"
        anti_patterns:
          - "Ignoring action tendencies (using vague names, implementation-level comments)"
          - "Violating bias principles (impure functions, complex UX, monolithic structure)"
          - "Violating rules (over-engineering, unreadable code, premature optimization)"
        dependencies: ["impulse", "extraction", "shaping", "injection"]
        outputs: ["code_generated", "methodology_aligned", "quality_validated"]
        
      - name: validation
        description: "Validate methodology application and catch issues before proceeding."
        quality_gates:
          - "Verified all previous stages were applied correctly"
          - "Confirmed methodology alignment (philosophy, archetype, biases applied)"
          - "Checked for common bug patterns and anti-patterns"
        anti_patterns:
          - "Skipping validation before proceeding to next stage"
          - "Not checking for methodology violations"
          - "Not catching common bug patterns early"
        dependencies: ["impulse", "extraction", "shaping", "injection", "modulation"]
        outputs: ["validation_report", "issues_found", "methodology_compliance"]
    
    feedback_loops:
      - name: "extraction_to_impulse"
        description: "If extraction reveals unclear motivation, return to impulse to clarify"
        trigger: "Missing or ambiguous human motivation in extracted signals"
        action: "Re-apply impulse stage to capture clearer motivation"
        
      - name: "shaping_to_extraction"
        description: "If shaping can't determine archetype, return to extraction to refine signals"
        trigger: "Insufficient signals to select appropriate archetype"
        action: "Re-apply extraction stage to identify missing signals"
        
      - name: "injection_to_shaping"
        description: "If injection reveals context gaps, return to shaping to refine approach"
        trigger: "Context inconsistencies or missing integration points"
        action: "Re-apply shaping stage to refine archetype selection or mode"
        
      - name: "modulation_to_injection"
        description: "If modulation reveals context issues, return to injection to refine integration"
        trigger: "Code doesn't align with intent context or philosophy"
        action: "Re-apply injection stage to strengthen context integration"
        
      - name: "validation_refinement"
        description: "If validation finds issues, return to appropriate earlier stage"
        trigger: "Validation fails quality gates or finds anti-patterns"
        action: "Identify root cause stage and re-apply from that point"
    
    stage_transitions:
      impulse_to_extraction:
        required_outputs: ["human_motivation", "emotional_tone"]
        handoff_criteria: "Motivation and tone clearly captured"
        
      extraction_to_shaping:
        required_outputs: ["structured_signals", "normalized_terminology"]
        handoff_criteria: "All key signals extracted and normalized"
        
      shaping_to_injection:
        required_outputs: ["design_archetype", "implementation_mode"]
        handoff_criteria: "Archetype selected with documented reasoning"
        
      injection_to_modulation:
        required_outputs: ["integrated_context", "philosophy_applied"]
        handoff_criteria: "Intent context fully integrated, philosophy applied"
        
      modulation_to_validation:
        required_outputs: ["code_generated", "methodology_aligned"]
        handoff_criteria: "Code generated with methodology principles applied"
        
      validation_to_complete:
        required_outputs: ["validation_report", "methodology_compliance"]
        handoff_criteria: "All quality gates passed, no anti-patterns found"
    
    context_preservation:
      required_artifacts:
        - "human_motivation: Preserved from impulse stage"
        - "structured_signals: Preserved from extraction stage"
        - "design_archetype: Preserved from shaping stage"
        - "integrated_context: Preserved from injection stage"
        - "methodology_alignment: Preserved from modulation stage"
      
      preservation_mechanisms:
        - "Explicit documentation at each stage transition"
        - "Terminology glossary maintained across stages"
        - "Archetype selection documented and referenced"
        - "Philosophy application verified at each stage"
        
      session_continuity:
        - "Constitution defines persistent cognitive stance"
        - "Intent artifacts (intent.md, plan.md, tasks.md) preserve context"
        - "Methodology application verified at start of each session"

  meta:
    created_by: "aicode"
    type: "intent_framework"
    scope: "vibe_coding_system"
    version_date: "2025-10-30"
```

## About Intent Kit and Intent CLI

**Intent Kit** is a comprehensive toolkit for implementing Intent-Driven Development (IDD) - a methodology that emphasizes creating clear intents before implementation. The toolkit includes templates, scripts, and workflows that guide development teams through a structured approach to building software.

**Intent CLI** is the command-line interface that bootstraps projects with the Intent Kit framework. It sets up the necessary directory structures, templates, and AI agent integrations to support the Intent-Driven Development workflow.

The toolkit supports multiple AI coding assistants, allowing teams to use their preferred tools while maintaining consistent project structure and development practices.

---

## General practices

- Any changes to `__init__.py` for the Intent CLI require a version rev in `pyproject.toml` and addition of entries to `CHANGELOG.md`.

## Adding New Agent Support

This section explains how to add support for new AI agents/assistants to the Intent CLI. Use this guide as a reference when integrating new AI tools into the Intent-Driven Development workflow.

### Overview

Intent supports multiple AI agents by generating agent-specific command files and directory structures when initializing projects. Each agent has its own conventions for:

- **Command file formats** (Markdown, TOML, etc.)
- **Directory structures** (`.claude/commands/`, `.windsurf/workflows/`, etc.)
- **Command invocation patterns** (slash commands, CLI tools, etc.)
- **Argument passing conventions** (`$ARGUMENTS`, `{{args}}`, etc.)

### Current Supported Agents

| Agent | Directory | Format | CLI Tool | Description |
|-------|-----------|---------|----------|-------------|
| **Claude Code** | `.claude/commands/` | Markdown | `claude` | Anthropic's Claude Code CLI |
| **Gemini CLI** | `.gemini/commands/` | TOML | `gemini` | Google's Gemini CLI |
| **GitHub Copilot** | `.github/prompts/` | Markdown | N/A (IDE-based) | GitHub Copilot in VS Code |
| **Cursor** | `.cursor/commands/` | Markdown | `cursor-agent` | Cursor CLI |
| **Qwen Code** | `.qwen/commands/` | TOML | `qwen` | Alibaba's Qwen Code CLI |
| **opencode** | `.opencode/command/` | Markdown | `opencode` | opencode CLI |
| **Codex CLI** | `.codex/commands/` | Markdown | `codex` | Codex CLI |
| **Windsurf** | `.windsurf/workflows/` | Markdown | N/A (IDE-based) | Windsurf IDE workflows |
| **Kilo Code** | `.kilocode/rules/` | Markdown | N/A (IDE-based) | Kilo Code IDE |
| **Auggie CLI** | `.augment/rules/` | Markdown | `auggie` | Auggie CLI |
| **Roo Code** | `.roo/rules/` | Markdown | N/A (IDE-based) | Roo Code IDE |
| **CodeBuddy CLI** | `.codebuddy/commands/` | Markdown | `codebuddy` | CodeBuddy CLI |
| **Amazon Q Developer CLI** | `.amazonq/prompts/` | Markdown | `q` | Amazon Q Developer CLI |
| **Amp** | `.agents/commands/` | Markdown | `amp` | Amp CLI |

### Step-by-Step Integration Guide

Follow these steps to add a new agent (using a hypothetical new agent as an example):

#### 1. Add to AGENT_CONFIG

**IMPORTANT**: Use the actual CLI tool name as the key, not a shortened version.

Add the new agent to the `AGENT_CONFIG` dictionary in `src/intent_cli/__init__.py`. This is the **single source of truth** for all agent metadata:

```python
AGENT_CONFIG = {
    # ... existing agents ...
    "new-agent-cli": {  # Use the ACTUAL CLI tool name (what users type in terminal)
        "name": "New Agent Display Name",
        "folder": ".newagent/",  # Directory for agent files
        "install_url": "https://example.com/install",  # URL for installation docs (or None if IDE-based)
        "requires_cli": True,  # True if CLI tool required, False for IDE-based agents
    },
}
```

**Key Design Principle**: The dictionary key should match the actual executable name that users install. For example:

- ✅ Use `"cursor-agent"` because the CLI tool is literally called `cursor-agent`
- ❌ Don't use `"cursor"` as a shortcut if the tool is `cursor-agent`

This eliminates the need for special-case mappings throughout the codebase.

**Field Explanations**:

- `name`: Human-readable display name shown to users
- `folder`: Directory where agent-specific files are stored (relative to project root)
- `install_url`: Installation documentation URL (set to `None` for IDE-based agents)
- `requires_cli`: Whether the agent requires a CLI tool check during initialization

#### 2. Update CLI Help Text

Update the `--ai` parameter help text in the `init()` command to include the new agent:

```python
ai_assistant: str = typer.Option(None, "--ai", help="AI assistant to use: claude, gemini, copilot, cursor-agent, qwen, opencode, codex, windsurf, kilocode, auggie, codebuddy, new-agent-cli, or q"),
```

Also update any function docstrings, examples, and error messages that list available agents.

#### 3. Update README Documentation

Update the **Supported AI Agents** section in `README.md` to include the new agent:

- Add the new agent to the table with appropriate support level (Full/Partial)
- Include the agent's official website link
- Add any relevant notes about the agent's implementation
- Ensure the table formatting remains aligned and consistent

#### 4. Update Release Package Script

Modify `.github/workflows/scripts/create-release-packages.sh`:

##### Add to ALL_AGENTS array

```bash
ALL_AGENTS=(claude gemini copilot cursor-agent qwen opencode windsurf q)
```

##### Add case statement for directory structure

```bash
case $agent in
  # ... existing cases ...
  windsurf)
    mkdir -p "$base_dir/.windsurf/workflows"
    generate_commands windsurf md "\$ARGUMENTS" "$base_dir/.windsurf/workflows" "$script" ;;
esac
```

#### 4. Update GitHub Release Script

Modify `.github/workflows/scripts/create-github-release.sh` to include the new agent's packages:

```bash
gh release create "$VERSION" \
  # ... existing packages ...
  .genreleases/intent-kit-template-windsurf-sh-"$VERSION".zip \
  .genreleases/intent-kit-template-windsurf-ps-"$VERSION".zip \
  # Add new agent packages here
```

#### 5. Update Agent Context Scripts

##### Bash script (`scripts/bash/update-agent-context.sh`)

Add file variable:

```bash
WINDSURF_FILE="$REPO_ROOT/.windsurf/rules/intent-rules.md"
```

Add to case statement:

```bash
case "$AGENT_TYPE" in
  # ... existing cases ...
  windsurf) update_agent_file "$WINDSURF_FILE" "Windsurf" ;;
  "") 
    # ... existing checks ...
    [ -f "$WINDSURF_FILE" ] && update_agent_file "$WINDSURF_FILE" "Windsurf";
    # Update default creation condition
    ;;
esac
```

##### PowerShell script (`scripts/powershell/update-agent-context.ps1`)

Add file variable:

```powershell
$windsurfFile = Join-Path $repoRoot '.windsurf/rules/intent-rules.md'
```

Add to switch statement:

```powershell
switch ($AgentType) {
    # ... existing cases ...
    'windsurf' { Update-AgentFile $windsurfFile 'Windsurf' }
    '' {
        foreach ($pair in @(
            # ... existing pairs ...
            @{file=$windsurfFile; name='Windsurf'}
        )) {
            if (Test-Path $pair.file) { Update-AgentFile $pair.file $pair.name }
        }
        # Update default creation condition
    }
}
```

#### 6. Update CLI Tool Checks (Optional)

For agents that require CLI tools, add checks in the `check()` command and agent validation:

```python
# In check() command
tracker.add("windsurf", "Windsurf IDE (optional)")
windsurf_ok = check_tool_for_tracker("windsurf", "https://windsurf.com/", tracker)

# In init validation (only if CLI tool required)
elif selected_ai == "windsurf":
    if not check_tool("windsurf", "Install from: https://windsurf.com/"):
        console.print("[red]Error:[/red] Windsurf CLI is required for Windsurf projects")
        agent_tool_missing = True
```

**Note**: CLI tool checks are now handled automatically based on the `requires_cli` field in AGENT_CONFIG. No additional code changes needed in the `check()` or `init()` commands - they automatically loop through AGENT_CONFIG and check tools as needed.

## Important Design Decisions

### Using Actual CLI Tool Names as Keys

**CRITICAL**: When adding a new agent to AGENT_CONFIG, always use the **actual executable name** as the dictionary key, not a shortened or convenient version.

**Why this matters:**

- The `check_tool()` function uses `shutil.which(tool)` to find executables in the system PATH
- If the key doesn't match the actual CLI tool name, you'll need special-case mappings throughout the codebase
- This creates unnecessary complexity and maintenance burden

**Example - The Cursor Lesson:**

❌ **Wrong approach** (requires special-case mapping):

```python
AGENT_CONFIG = {
    "cursor": {  # Shorthand that doesn't match the actual tool
        "name": "Cursor",
        # ...
    }
}

# Then you need special cases everywhere:
cli_tool = agent_key
if agent_key == "cursor":
    cli_tool = "cursor-agent"  # Map to the real tool name
```

✅ **Correct approach** (no mapping needed):

```python
AGENT_CONFIG = {
    "cursor-agent": {  # Matches the actual executable name
        "name": "Cursor",
        # ...
    }
}

# No special cases needed - just use agent_key directly!
```

**Benefits of this approach:**

- Eliminates special-case logic scattered throughout the codebase
- Makes the code more maintainable and easier to understand
- Reduces the chance of bugs when adding new agents
- Tool checking "just works" without additional mappings

#### 7. Update Devcontainer files (Optional)

For agents that have VS Code extensions or require CLI installation, update the devcontainer configuration files:

##### VS Code Extension-based Agents

For agents available as VS Code extensions, add them to `.devcontainer/devcontainer.json`:

```json
{
  "customizations": {
    "vscode": {
      "extensions": [
        // ... existing extensions ...
        // [New Agent Name]
        "[New Agent Extension ID]"
      ]
    }
  }
}
```

##### CLI-based Agents

For agents that require CLI tools, add installation commands to `.devcontainer/post-create.sh`:

```bash
#!/bin/bash

# Existing installations...

echo -e "\n🤖 Installing [New Agent Name] CLI..."
# run_command "npm install -g [agent-cli-package]@latest" # Example for node-based CLI
# or other installation instructions (must be non-interactive and compatible with Linux Debian "Trixie" or later)...
echo "✅ Done"

```

**Quick Tips:**

- **Extension-based agents**: Add to the `extensions` array in `devcontainer.json`
- **CLI-based agents**: Add installation scripts to `post-create.sh`
- **Hybrid agents**: May require both extension and CLI installation
- **Test thoroughly**: Ensure installations work in the devcontainer environment

## Agent Categories

### CLI-Based Agents

Require a command-line tool to be installed:

- **Claude Code**: `claude` CLI
- **Gemini CLI**: `gemini` CLI  
- **Cursor**: `cursor-agent` CLI
- **Qwen Code**: `qwen` CLI
- **opencode**: `opencode` CLI
- **Amazon Q Developer CLI**: `q` CLI
- **CodeBuddy CLI**: `codebuddy` CLI
- **Amp**: `amp` CLI

### IDE-Based Agents

Work within integrated development environments:

- **GitHub Copilot**: Built into VS Code/compatible editors
- **Windsurf**: Built into Windsurf IDE

## Command File Formats

### Markdown Format

Used by: Claude, Cursor, opencode, Windsurf, Amazon Q Developer, Amp

```markdown
---
description: "Command description"
---

Command content with {SCRIPT} and $ARGUMENTS placeholders.
```

### TOML Format

Used by: Gemini, Qwen

```toml
description = "Command description"

prompt = """
Command content with {SCRIPT} and {{args}} placeholders.
"""
```

## Directory Conventions

- **CLI agents**: Usually `.<agent-name>/commands/`
- **IDE agents**: Follow IDE-specific patterns:
  - Copilot: `.github/prompts/`
  - Cursor: `.cursor/commands/`
  - Windsurf: `.windsurf/workflows/`

## Argument Patterns

Different agents use different argument placeholders:

- **Markdown/prompt-based**: `$ARGUMENTS`
- **TOML-based**: `{{args}}`
- **Script placeholders**: `{SCRIPT}` (replaced with actual script path)
- **Agent placeholders**: `__AGENT__` (replaced with agent name)

## Testing New Agent Integration

1. **Build test**: Run package creation script locally
2. **CLI test**: Test `intent init --ai <agent>` command
3. **File generation**: Verify correct directory structure and files
4. **Command validation**: Ensure generated commands work with the agent
5. **Context update**: Test agent context update scripts

## Common Pitfalls

1. **Using shorthand keys instead of actual CLI tool names**: Always use the actual executable name as the AGENT_CONFIG key (e.g., `"cursor-agent"` not `"cursor"`). This prevents the need for special-case mappings throughout the codebase.
2. **Forgetting update scripts**: Both bash and PowerShell scripts must be updated when adding new agents.
3. **Incorrect `requires_cli` value**: Set to `True` only for agents that actually have CLI tools to check; set to `False` for IDE-based agents.
4. **Wrong argument format**: Use correct placeholder format for each agent type (`$ARGUMENTS` for Markdown, `{{args}}` for TOML).
5. **Directory naming**: Follow agent-specific conventions exactly (check existing agents for patterns).
6. **Help text inconsistency**: Update all user-facing text consistently (help strings, docstrings, README, error messages).

## Future Considerations

When adding new agents:

- Consider the agent's native command/workflow patterns
- Ensure compatibility with the Intent-Driven Development process
- Document any special requirements or limitations
- Update this guide with lessons learned
- Verify the actual CLI tool name before adding to AGENT_CONFIG

---

*This documentation should be updated whenever new agents are added to maintain accuracy and completeness.*
