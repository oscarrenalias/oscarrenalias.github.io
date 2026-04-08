+++
title = "From Coding Assistants to Autonomous Software Engineering (Part 2)"
date = 2026-04-08T00:00:00Z
draft = true
header_image = "/images/articles/ai-coding-assistants-beyond-the-hype.png"
header_image_alt = "AI-assisted software development workflow visualization"
+++
# Part 2

This is my approach to an agentic engineering system.

## Overview

Your bead-based orchestrator sounds like the core harness controller in this model: it is primarily the control loop, and secondarily the verification and safety layer around the coding agent. 

It enforces a staged flow from spec to design, build, test, and documentation with retries and human escalation, it is doing the kind of planning, decomposition, recovery, and approval handling that harness literature places in the orchestration layer.

The system is the control plane of an agentic coding harness: it accepts a specification, decomposes work into enforced phases such as design, build, test, and documentation, and allows agents to operate only within that governed workflow. 

It also applies retries, quality gates, and human escalation, and serves as the verification and safety layer that keeps autonomous coding aligned with engineering standards rather than letting the model self-manage the whole lifecycle. Models on their own cannot be trusted to al

## Terminology

### Bead

Minimum unit of work.
xx TODO define me

Types of beads:

- **develop**: TODO
- **review**: TODO
- **test**: TODO
- **document**: TODO
- **corrective**: a "bug" bead TODO

Additional bead types can be defined over time if needed, but these are the core minimum core set required to operate the system.

### Agents

Five built-in types:  

- **planner**: Responsible for taking a spec and breaking it down into a plan, as a set of beads that will drive the implementation of the spec/feature including build, test and document work. The planner agent has wide latitude to define the number of beads, their granularity and sequence (defined via dependencies between beads), but will always enforce quality gates, i.e., every feature will have at least one test, review and documentation bead. 
- **developer**: Responsible for writing code. Handles *develop* and *corrective* beads. 
- **tester**: Tests code. Handles *test* beads
- **reviewer**: Reviews one or more beads, depending on how the planner sets up the plan. Handles *review beads*.
- **documenter**: Ensures that documentation is updated after a spec is implemented. 

Each agent type is provided with steering, skills, tools and a model that is selected according to its task:

- **steering**: predefined steering that narrowly defines its scope and main activities
- **skills**: predefined set of skills according to the agent's purpose, e.g,. the documenter agent has access to tools to review and update documents, but not to write code
- **

The planner will always guarantee that at least one *test*, *review* and *documentation* bead are present as part of the spec planning flow. If a developer bead is injected manually into the system, the scheduler will automatically create *test*, *review* and *documentation* beads to guarantee the quality gate flow. 

### Runners (backends)

Currently, two agent backends are supported:

* OpenAI Codex
* Claude Code

Both provide equivalent levels of reasoning and code quality. Claude Code is a bit better in terms of session telemetry, i.e., it provides a lot more insight into what took place during a session such as number of turns, total tokens (cached/non-cached), price per session, etc. This may be relevant when identifying where to optimize the system in terms of expensive prompts, excessively long sessions, and others. 

### Workflow

Workflow is enforced: plan -> develop -> test -> review -> document

There currently is no way to alter this flow -- this is by design. 

### Planning

- quality gate: xx TODO define me

## How does it work?

The system takes a spec as input, decides the sequence of phases, and governs progression between them instead of letting the coding model  free-run. It also enforces safety and verification, since quality gates, retries, and escalation are deterministic checks that validate output quality and stop or redirect execution when standards are not met, e.g., i case of issues found during review or testing, the orchestrator will queue a new work item (a bead) to address the issue, requeue the failed testing or review bead, until the issue is finally fixed.

The orchestrator also persists task state, phase status, and prior outcomes between agent turns – it owns memory and state management in harness terms. 

The system aslso decides which agent each phase, then it is also the layer coordinating the action surface and interpreting observations from tests, logs, or review results.

Practical mapping
A simple way to frame it is this: the coding model is the worker, while your bead-based orchestrator is the process engine that enforces enterprise delivery discipline around that worker. In other words, your system is not just “part of” the harness; it is probably the backbone of the harness, with tool adapters and execution environments sitting underneath it.

One-line taxonomy
You could describe it as an opinionated orchestration harness for agentic software delivery, with built-in stage gates, validation loops, and human-governed exception handlin