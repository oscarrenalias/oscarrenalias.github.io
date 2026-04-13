+++
title = "From Coding Assistants to Autonomous Software Engineering (Part 2): Takt"
date = 2026-04-13T00:00:00Z
draft = false
header_image = "/images/articles/takt-hero.png"
header_image_alt = "AI-assisted software development workflow visualization"
+++
## From Agentic Possibility to Agentic Discipline: An Opinionated Harness for the Enterprise

Agentic development has moved quickly from code suggestion to delegated execution. Models can now inspect repositories, modify files, carry out substantial portions of delivery work with limited human intervention.

Enterprise adoption is not about powerful models anymore but about discipline. Powerful agents still tend to behave like highly capable but weakly governed contributors: they will often skip tests, forget documentation, drift from scope, and lose coherence across longer tasks unless something external keeps them on track.

The real differentiator in the next phase of agentic software delivery will be the harness: a prescriptive workflow with memory and the ability to decompose tasks into small units that agents can manage with minimal turns and tokens — turning impressive coding capability into a repeatable engineering system.

This article introduces an opinionated approach to addressing the limitations of current models and agentic systems. The goal is to show what a more disciplined harness can look like in practice, and how stronger workflow enforcement can make delegated software delivery more dependable.

## Introducing Takt

Now that agents with 1M token contexts can take care of most enterprise codebases, enterprises need better harnesses.

[Takt](https://github.com/oscarrenalias/takt) takes its name from the Six Sigma concept of Takt Time — the controlled cadence that keeps production moving at a sustainable, repeatable pace. The goal is the same: a harness designed to make agentic delivery more disciplined, traceable, and repeatable. It addresses the gaps outlined in [Part 1](/articles/agentic_development_evolution_article_part_1/) through structured workflow enforcement, bead-based decomposition, specialized workers, Git-native isolation, self-healing follow-up, and stronger visibility into what agents did and why.

### The design principles behind Takt

Takt is built around a small set of principles:

- Workflow should be enforced rather than suggested
- Large tasks should be decomposed into smaller, manageable units
- Different stages of work should be handled by specialized workers, scoped to very specific tasks and with a very specific set of tools available to them
- Execution should be isolated and Git-native
- The system should be able to detect failure and generate corrective follow-up
- Institutional long-term memory, so that every agent session doesn't start from scratch

These design principles aim to make agentic software engineering more reliable than the "bare" general-purpose models that currently dominate much of the current tooling landscape.

### Takt Architecture

{{< figure src="/images/articles/takt-architecture.png" caption="Takt Architecture" >}}

At a high level, Takt is split into two loops. The outer loop is where the human operator works with an operator agent (Claude Code, Codex) to shape the problem, refine ideas, and turn that thinking into a spec. This is the spec-driven layer: dialogue happens here, scope is clarified here, and the operator remains in control of what the system is being asked to do. The operator agent knows how to drive Takt, and how to drive specs through the lifecycle via skills that are installed as part of the Takt onboarding process. It can also fix issues with the system when they arise, e.g., difficult merges.

The inner loop begins once that spec is handed over to Takt. From that point on, Takt takes care of decomposing the work into beads, routing those beads through the workflow, assigning them to the right specialized agents, and using memory and scheduling to keep execution moving. The outer loop is about defining the work, while the inner loop is about driving that work to completion in a controlled and repeatable way.

While the outer loop isn't necessarily required since Takt can be operated by a human from the CLI, working with an agent that knows how to operate it is what makes the process truly agentic as the operator can watch after the process, fix issues if any arise, and eventually manage the process to merge code back into the root of the repository.

### The bead model: breaking large work into enforceable units

In Takt, the bead is the core unit of orchestration. Instead of treating a feature or change request as one broad task, Takt breaks it into smaller, explicit beads that can be scheduled, assigned, tracked, and verified independently.

{{< figure src="/images/articles/takt-bead-graph.png" caption="Bead dependency graph for a typical feature" >}}

Each bead has a clear purpose, a bounded scope, and a defined place in the workflow. Beads can depend on earlier beads, generate new beads when follow-up is needed, and move through the system with their status visible at each step. This gives Takt a practical way to enforce progress: large work is reduced to a graph of manageable units, and the system advances that graph in a controlled, traceable manner rather than relying on a single agent to hold the entire task together.

### Opinionated by design: why prescriptive workflow matters

Takt enforces workflow by turning work into a structured sequence of beads that move through explicit stages rather than through one long, open-ended agent session. Each bead represents a bounded unit of work, is assigned a specific place in the pipeline, and is routed to a worker designed for that stage. Workflow becomes part of the runtime itself: progress is tracked bead by bead, stage by stage, instead of being left to the memory of a general-purpose agent.

This matters because the system can enforce what happens next. Planning feeds implementation beads, implementation can lead into test, documentation, and review, and execution happens in isolated Git worktrees rather than in a shared, ambiguous session. Takt’s workflow is also designed to recover itself: when a bead is blocked, fails validation, or produces an unusable result, the system can generate corrective follow-up beads and route them through the same controlled process as any other unit of work. 

### Specialized workers instead of one general-purpose agent

Takt does not assume that a single general-purpose agent should design, build, test and document an entire feature beginning to end. It defines distinct worker types for distinct stages of delivery:

- **Planner**: decomposes work into bead graphs and defines the execution plan
- **Developer**: implements changes within a bounded scope
- **Tester**: adds or updates targeted tests and validates changes
- **Documentation**: updates documentation without changing runtime behavior
- **Review**: inspects changed files and decides pass or fail
- **Investigator**: performs read-only analysis and writes a structured report
- **Merge-conflict**: resolves merge conflicts inside the assigned worktree

Just as important, each worker has a pre-defined tool boundary. Developer agents can modify code and run only a quick syntax or build check, but they cannot run tests; tester agents can write tests and run targeted validation, but not the full suite or broader feature work; review agents are read-only and do not fix issues; documentation agents update documentation only; and investigator agents are limited to read-only analysis plus a single report file.

Takt scopes what an agent can do through role-specific guardrails in addition to steering, limiting actions and tool access, while keeping the workflow cleanly separated.

Additionally, agent steering files are provided as template that can be tweaked by users to suit the needs of specific projects when the default ones are not enough.

### Git-native execution: worktrees, isolation, and parallelism

Takt is Git-native by design. Beads live in the repository as JSON files, their state changes are tracked like any other artifact, and execution happens in Git worktrees rather than inside one shared working directory. In practice, that means each bead can run in isolation on its own branch and worktree, with a clean boundary around the files it changes and the history it produces.

Git worktrees give Takt two practical advantages. First, it reduces interference: parallel workers do not step on each other because they are not operating in the same workspace. Second, it makes orchestration easier to reason about, because each unit of work has its own execution context, branch history, and merge path back into the wider feature. This is a better fit for serious software delivery than a model where multiple agents act against the same ambiguous session state.

### Specs outlive the conversation

In Takt, specs are more than planning notes: they are part of the execution interface between the operator and the system. The workflow I am embracing here is often dialogue first, spec next. A long discussion with an agent helps surface the problem, test ideas, and refine the approach; once the shape of the solution is clear enough, that thinking is distilled into a spec that can guide the rest of delivery. Specs do not replace dialogue, but they stabilize it and turn it into something agents can act on repeatedly.

Prompts are transient and sessions eventually lose detail, but a spec can preserve intent and design choices in a durable form. In Takt, the spec is a persistent artifact that explains what should be built, why it should be built that way, and what purpose it is meant to serve throughout execution.

### Long-term persistent institutional memory

Takt also includes a long-term memory layer for the project as a whole. It gives agents a shared place to look for relevant knowledge and to store what they learn as they work, so useful context does not remain trapped inside one session or one agent. Memory is backed by a database with semantic search, making it possible to retrieve relevant knowledge when it is needed rather than relying on static notes or fragile session context.

At bead start, agents search memory before working, and they can write back new findings at the end of their work, either for a later time or for the next agent that will pick up the spec or bead. That process produces a more durable institutional memory that is searchable, shared across operator and workers, and designed to preserve relevant knowledge instead of forcing every run to start from scratch.

### Support for multiple coding assistants

Takt currently supports two coding assistants: Codex and Claude Code.

The architecture leaves room for more backends to be added over time, but in practice these are the only two I have focused on, because they are the ones I actively work with. The support surface is intentionally narrow for now, but still broad enough to prove that the framework is not tied to a single coding agent.

## Observability and traceability: seeing what agents did, why, and at what cost

Takt gives operators visibility into the actual flow of work rather than just the final output. Bead states, execution history, agent handoffs, and workflow progression are all visible as part of the system, making it easier to understand what happened, where things are blocked, and how a result was produced.

Cost and usage are equally visible. Because work is broken into explicit units and routed through defined stages, it becomes much easier to see which parts of the process consumed time, tokens, and effort. Claude Code is particularly strong here, because its usage reporting gives clear insight into what each bead and each feature root actually costs.

{{< figure src="/images/articles/takt-telemetry-screenshot.png" caption="Example Takt cost and bead telemetry" >}}

## What Takt does well today

Takt already expresses a clear point of view: agentic software delivery should be opinionated, staged, and constrained. For teams that share that premise, its value is that it runs agents in a way that is easier to govern, reason about, and align with disciplined engineering practice.

As of the time of writing this article, Takt has been self-hosting for several weeks (developing itself) and has worked on nearly 1100 beads through several tens of specs. I have also onboarded several of my own projects into Takt and outcomes are very positive so far:

- clear process enforced end-to-end
- tests, lots of tests... more than I would ever create by myself; e.g., the Takt test suite has over 1200 test cases that do the job
- up-to-date documentation after every change

## Current limitations and trade-offs

Although it has come a long way and it works for my needs, Takt still has some clear limitations that hamper its ability to become a general-purpose agentic harness:

- Thoroughly tested with Claude Code, and to a lesser extent with Codex. Support for both exists today, but the depth of real-world validation is not yet the same across the two.
- Its workflow is also inherently more token-intensive than conventional prompt-based development. Staged, multi-agent execution with planning, testing, documentation, and review simply costs more tokens than a single conversational loop.
- Takt supports multiple languages and frameworks out of the box, including Python, Node.js, TypeScript, Go, Java, Rust, and a generic fallback mode. In practice, however, most of my own work has been in Python, so support outside that ecosystem should still be considered less thoroughly exercised.
- Takt assumes one language, one test command, and one build pipeline per repository. Monorepos with multiple stacks or frameworks (e.g. a Python backend and a JavaScript frontend) are not well supported: the test command is global, and agent guardrails are not stack-aware.

## Closing: why I built an opinionated system rather than a generic framework

I built Takt as an opinionated system because the current landscape already has plenty of flexible tools, generic orchestration layers, and open-ended agent runtimes, but is still missing stronger structure: a way to make agents operate inside a disciplined delivery model rather than around it. Takt is less universal than a generic framework on purpose, with the aim to make one serious workflow work reliably.

My assumption is that model vendors, or someone else in the ecosystem, will eventually converge on a more opinionated and widely adopted layer for agentic delivery: the equivalent of what Kubernetes became for Docker containers. Today, that standard layer does not really exist yet but Takt is my own attempt to move in that direction and to show what such a system could look like.

Workflow will matter more than raw model capability. Model quality will continue to improve, but the hard part is the process around it – that is what Takt is trying to be: proof that the process matters as much as the model.