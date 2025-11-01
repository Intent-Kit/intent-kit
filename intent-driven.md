# Intent-Driven Development (IDD)

## The Intent-First Philosophy

Traditional software development follows a code-first approach where implementation drives documentation and requirements. Intent-Driven Development (IDD) flips this paradigm by making clear, executable intents the primary driver of all development activities.

In IDD, the intent represents the "what" and "why" of what needs to be built. It includes user needs, business requirements, and expected outcomes. The implementation details represent the "how" and are derived from the intent rather than the other way around.

This approach ensures that every line of code serves a specific purpose defined in the original intent, reducing waste and maintaining clear alignment between business objectives and technical implementation.

## Core Principles of Intent-Driven Development

**1. Intent as Source of Truth**
The written intent document serves as the single source of truth for all development activities. All code, tests, and design decisions trace back to specific elements in the intent.

**2. Progressive Elaboration**
Intents start high-level and become more detailed through structured refinement. Initial broad intents are gradually clarified and expanded with specific requirements and constraints.

**3. Automatic Traceability**
Every implementation element maintains a clear link to the original intent. This enables rapid impact analysis when business requirements change.

**4. Validation-First Approach**
Before implementation begins, the intent is validated against business objectives, technical constraints, and user needs. This prevents building the wrong solution.

**5. Adaptive Implementation**
The implementation process remains flexible and can adapt to new information or changes in business priorities while maintaining alignment with core intent elements.

## The IDD Workflow

The Intent Kit provides a structured workflow that guides teams through intent-driven development:

### 1. Capture Intent (`/intent.capture`)

Transforms initial feature descriptions into structured, executable intents. This command:

- Creates a numbered feature directory (e.g., `001-user-authentication`)
- Generates a comprehensive intent document with user stories and acceptance criteria
- Establishes feature-specific branch and directory structure
- Incorporates organizational constraints and technical requirements

### 2. Plan Implementation (`/intent.plan`)

Converts the intent document into a detailed implementation plan that:

- Maps business requirements to technical architecture
- Ensures compliance with project constitution and principles
- Defines data models, API contracts, and integration points
- Creates test strategies aligned with acceptance criteria
- Maintains traceability between intent elements and technical decisions

### 3. Generate Tasks (`/intent.tasks`)

Creates executable task lists from implementation plans that:

- Break down complex features into discrete, actionable tasks
- Identify parallelizable work to optimize development velocity
- Specify file paths and implementation order
- Include validation checkpoints throughout the process

### 4. Execute Implementation (`/intent.implement`)

Carries out the planned implementation following:

- Test-driven development principles
- Architectural constraints from the project constitution
- Progressive validation and feedback loops
- Quality gates and compliance checks

## Advantages of Intent-Driven Development

**Clear Requirements Alignment**: Every implementation decision directly supports documented intent elements, reducing scope creep and misalignment.

**Rapid Adaptation**: When business requirements change, the impact on implementation is clear and manageable because of established traceability.

**Reduced Waste**: By validating intent before implementation, teams avoid building features that don't meet business objectives.

**Improved Collaboration**: Shared intent documents provide common context for business stakeholders, product managers, and development teams.

**Sustainable Evolution**: Software evolves in alignment with original intent, maintaining architectural coherence over time.

## The Intent Kit Ecosystem

Intent Kit provides templates, scripts, and workflows that operationalize intent-driven development:

- **Structured Templates**: Guide the creation of comprehensive intents and implementation plans
- **Automated Workflows**: Streamline the progression from intent to working software  
- **Quality Gates**: Enforce architectural and quality standards throughout implementation
- **Traceability Tools**: Maintain links between intent, plan, and implementation elements
- **Validation Frameworks**: Ensure implementation matches original intent and business objectives

## Getting Started with Intent Kit

Intent Kit is designed to work with AI coding assistants like Claude, Cursor, GitHub Copilot, and others. The process starts with establishing project principles using `/intent.constitution`, then progresses through intent capture, planning, task generation, and implementation.

This systematic approach transforms software development from an ad-hoc process into a predictable, traceable, and quality-driven methodology that consistently delivers business value through clear intent alignment.
