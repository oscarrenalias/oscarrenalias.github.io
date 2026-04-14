+++
title = "From Coding Assistants to Autonomous Software Engineering (Part 1)"
date = 2026-04-08T00:00:00Z
draft = false
header_image = "/images/articles/agentic-development-evolution-article-part-1.png"
header_image_alt = "AI-assisted software development workflow visualization"
description = "Software development has evolved from AI autocomplete to agents that plan and execute across entire codebases — yet enterprises still face critical gaps in workflow enforcement, memory, and traceability. An examination of the evolution and what it means for enterprise adoption."
+++

## Executive summary

Software development has shifted from coding assistants that "autocomplete" to systems that can read repositories, plan work, and execute changes, wielding \~1M-token contexts that allow them to operate across large codebases without constantly compacting or dropping context. 

However, most commercial coding tools remain advanced assistants. They are very good at what they do, but they still leave it to enterprises to integrate controls and governance and to connect these agents into a cohesive, opinionated end‑to‑end process that provides the reliability, repeatability, quality, and traceability required at enterprise scale.

## Evolution of Agentic Development

The past few years have seen a rapid progression from simple code completion to systems capable of reasoning over entire codebases and executing multi-step workflows. Understanding this evolution is key to framing what has changed—and why traditional development assumptions no longer hold.

1. **From autocomplete to AI collaborators**: Early tools focused on single-file completion and IDE assistance. Transformer models expanded this to multi-language generation and chat-based interaction. By 2023–2024, tools combined conversation, repo awareness, and multi-file edits. Humans still drove execution, but the foundation for agentic workflows was established.

2. **Emergence of coding agents**: Recent systems behave more like asynchronous teammates. They can analyze repositories, make multi-file changes, run tests, and produce pull requests with the ability to interrupt the agentic process and request missing information from human operators. These agents integrate into existing workflows (e.g., CI/CD, PRs) and can be specialized for tasks like testing or documentation. The shift is from assisting tasks to executing workflows.

3. **Evolution of coding models**: Models have progressed toward stronger reasoning, tool use, and larger context windows. Families such as Haiku, Sonnet, and Opus reflect trade-offs between speed, cost, and capability. 1M-token context enables handling large codebases and extended sessions. The key question is no longer “best model,” but to assign the right model to the right task.

## From assistance to delegation

The evolution is clear: from supporting developers as coding sidekicks to executing on their behalf in a nearly autonomous manner.

The interaction moves from prompt-response to goal-driven workflows (plan, execute, validate), typically supported by some kind of task ledger or TODO list. Agents become part of the team to whom work can be assigned, delegated and governed like any other contributor.

## Gaps in current offerings

While capabilities have advanced significantly, a small number of structural gaps consistently prevent agentic systems from operating reliably in enterprise environments.

- **Generalistic agents**: Coding agents tend to work better when their tasks are narrowly scoped, as opposed to long-running open-ended tasks.

- **Lack of enforced workflows**: There is no reliable way to guarantee that design, reviews, testing, and documentation are consistently executed as part of every task, leaving outcomes dependent on the agent’s behavior rather than a controlled process.

- **Fragile memory and lack of institutional learning**: Sessions start with partial knowledge, prior decisions are not persistently captured, and long-running context is eventually compacted or lost. There is no robust mechanism for feeding learnings back into shared memory, resulting in repeated work and inconsistent decisions.

- **Non-deterministic execution**: Agents can overlook steps, deviate from intent, or produce different results for the same input, making it difficult to guarantee completeness and repeatability without structured, enforceable processes.

- **Limited visibility and traceability**: It is often unclear why an agent made a decision, what context it used, or how a specific output was produced, limiting auditability and trust.

- **Shallow enterprise integration**: Most tools do not natively align with enterprise SDLC practices, requiring custom wiring to connect agents with CI/CD pipelines, governance controls, and existing engineering standards.

## Why workflow matters

As model capabilities converge, differentiation shifts to the workflow stack as the means to enforce a specific process with guardrails, traceability, to make it predictable.

An effective system requires:

- **Interaction layer**: IDE, chat, tickets
- **Orchestration**: agents, routing, policies
- **Execution**: CI/CD, environments
- **Knowledge**: code, architecture diagrams, prior decisions, specifications, design documents, and others

Without this structure, agents remain isolated tools rather than part of a coherent SDLC.

## What does this mean for enterprises?

Most organizations are assembling custom combinations of models, agents, and tooling. The strategic step is defining what to delegate, how to govern it, and how agents integrate into the SDLC, so that autonomous agents can massively increase productivity without compromising quality.

## The harness

What's a *harness*?

A harness is the runtime layer around the model that makes a coding agent usable for real work, rather than just a chatbot that suggests (good) code. In agentic coding, it is the software that handles everything besides the model’s raw reasoning: tools, context, state, validation, retries, and most importantly, flow.

### What does it do?

A harness decides what the agent can do and how it does it, such as reading files, running tests, calling linters, using a shell, or triggering other tools under defined permissions and limits. It also manages the loop around the model: break work into steps, pass the right context, check outputs, retry failures, and keep logs or traces of what happened.

### In coding agents

For coding specifically, the harness is often what enables the familiar cycle of *“write code, run tests, inspect errors, fix code, repeat”* (repeat autonomously, that is) without constant manual copy-paste. 

That is why people say the model provides the intelligence, but the harness is what makes the agent reliable, steerable, and compliant with a specific prescriptive process.

In essence, a harness is the more opinionated runtime system that assembles everything into a working, controlled workflow. Think about it this way: orchestration is the plan, the model is the reasoner, and the harness is the operational layer that carries the plan out safely and consistently through the orchestration.

*Practical example*: If you ask an agent to “add OAuth login,” the harness may fetch relevant files (or point the agent to them), let the model edit code, run tests, deny risky commands, ask for approval at certain thresholds, review the outputs, make sure they're documented, and store some of the things that the agent learned for the next work item. 

### What's in a harness?

In practice, there is not one universally fixed taxonomy for an agentic coding harness, but most descriptions converge on five practical parts:

* **Action surface**: the commands and tools the agent can use, such as file edits, bash, repo search, test runners, browsers, and APIs.
* **Observation surface**: the feedback the agent gets back after acting, including diffs, stderr, logs, stack traces, screenshots, and test output.
* **Memory and state**: the way the harness stores durable project knowledge, session progress, and context outside the model’s transient prompt window, typically in long-term persistent storage such as database with vector search capabilities.
* **Control loop and orchestration**: the logic that plans, executes, retries, compacts context, hands work to subagents, and decides what happens next after each step.
* **Safety and verification**: the sandboxing, permissions, validation, tests, guardrails, and approval checks that keep the agent reliable and prevent unsafe or premature completion.

Together, these parts turn a regular powerful coding **model** into an agentic and autonomous coding **system** that can act, inspect results, persist progress, and keep itself on track over longer tasks in a fully autonomous manner.

In our prior example, in a feature task like *“add OAuth login,”* the action surface edits files and runs tests, the observation surface returns failures and diffs, memory keeps project rules and prior progress, the control loop decides the next fix, and safety gates block risky commands or require approval. That is why the model is only one small part of the whole picture, while the harness is the system that makes the model dependable and repeatable in practice.

## What are we doing about it?

There’s a lot of interesting work happening around agentic harnesses right now: open‑source frameworks, vendor platforms, internal experiments. But unlike the way Kubernetes emerged as the runtime standard around Docker containers, nothing has yet consolidated into a de facto “Kubernetes for coding agents.” Most teams are quietly building their own runtimes, glue code, and guardrails—and discovering the same sets of problems the hard way.

In [Part 2](/articles/agentic_development_evolution_article_part_2/), I walk through a concrete harness implementation: my own opinionated take on how the action and observation surfaces are defined, how memory and state are handled, which safety gates sit in front of the model, and what actually happened when real feature work was run through it. The goal is not to propose yet another “standard,” but to offer a practical design that others can borrow from, critique, or improve.