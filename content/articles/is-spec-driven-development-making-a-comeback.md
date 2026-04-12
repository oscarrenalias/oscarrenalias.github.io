+++
title = "Is spec-driven development becoming relevant again?"
date = 2026-04-10T00:00:00Z
draft = false
header_image = "/images/articles/is-spec-driven-development-making-a-comeback   .png"
header_image_alt = "AI-assisted software development workflow visualization"
+++

## In the age of agentic systems, specs matter again

In most serious software environments, some form of specification has always existed. It may not always have been called a spec, and it may not always have been formal, but the practice never disappeared. Teams have long relied on architecture notes, tickets, RFCs, ADRs, implementation plans, and acceptance criteria to make intent more explicit before work begins.

What changed was not the existence of specs, but their prominence. In many teams, a lot of detail could safely remain implicit because experienced humans filled in the gaps. They could infer context from conversations, remember prior decisions, ask clarifying questions, and spot contradictions quickly. A short *“qq?”* message in Teams or Slack often worked because the other person already understood the environment.

Agentic systems change that equation as they need to be provided with sufficient context to increase the changes of getting the right and expected outcome.

## Dialogue first, specs next

When working with agents, there are broadly two ways of approaching the task.

One is to stay in a conversational mode: give the system a brief instruction, iterate quickly, and let the back-and-forth shape the solution. I like the term dialogue-driven development, as used by Ilkka Anttonen, because it captures this mode well. For exploratory work,  prototyping, it is often exactly the right approach. It is fast, interactive, and well suited to problems whose shape is still emerging. It also builds on the intelligence and eagerness of current agents to provide something that works with very little guidance – "here's my idea, it's not very well defined but show me what you can do with it"

The other approach is to spend a bit more time designing before execution starts. That means writing down enough of the problem, the goals, the constraints, the key design choices, and the known risks so that the system has a fuller brief to work from. That is what I mean here by spec-driven development.

## My personal experience

In my own work, the dialog-driven development and spec-driven development approaches often happen as part of the same flow. I may spend a long, sometimes very long, time in dialogue with the agent first: exploring the problem, testing ideas, challenging assumptions, and gradually getting to a clearer view of what should be built. 

At some point, once the shape of the solution is clear enough, I will distill that conversation and my current mental model into a fuller specification. From there, the spec becomes the artifact I iterate on with the agent until the outcome is where I want it to be. That is a good example of why specs do not replace dialogue. They complement it. Dialogue helps surface the idea; the spec helps stabilize it and carry it forward.

Once I'm happy with the spec, I can feed it into an agent or an agentic development system, make it analyze it and eventually build it.

## Why specs become more valuable with agents

That distinction matters more as systems become more agentic, and this is where I have found longer-form specifications especially useful as the act of writing forces a more disciplined synthesis of the work. Throughout the process, I've  found that agents will happily generate code through simple prompts, but will also be happy to work with you through tradeoffs, decisions and risks as you build context through a dialogue.

That is one reason this practice feels familiar to experienced engineers. Writing often serves both purposes: communicating a design and arriving at one.

## The spec as an execution interface

Im my opinion, the spec is becoming part of the interface between humans and agentic systems. If prompts are the conversational layer, specs are the durable coordination layer.

Specs should also become part of the agent’s memory. Specs give agents something  to check on later later, as memory: when a feature was designed, how it was designed, what trade-offs were made, and which purpose it was meant to serve. Session prompts and chat context often get compacted, summarized, and eventually lost over time. Specs remain, as long as we store them somewhere durable and make them available to agents later on.

## This is not a return to heavyweight process

it's important that "spec-driven development", in the age of agentic system, does not mean a return to a heavyweight process with complex spec templates that require endless review sessions. The case here is for deliberate lightweight specs rather than exhaustive documents, bureaucratic gates, or analysis paralysis. The more independently you want an agent to act, the more complete your written intent needs to be -- specs should no more, no less, than what is required for an agent to complete the task at hand.

Not back to waterfall, but adaptation

So is spec-driven development making a comeback? Perhaps. A better way to describe it is that the practice is being revalidated under new conditions.

As software delivery becomes more agentic, specifications become more valuable. More work is being delegated, and that changes what has to be made explicit. When more work is delegated, context has to travel better. A couple of statements in a prompt may be enough for some tasks. For others, a more deliberate written artifact is simply a better interface.

We're not going to heavyweight waterfall software development, but adapting.

## Side note: from practice to tooling

Over time, this dialogue-to-spec workflow has become regular enough for me that I built a lightweight skill to help manage specs in basic Markdown format. The goal is to make it easier to capture a spec, evolve it, and move it through a simple lifecycle as the work became clearer.

I have open-sourced that approach here: [skill-spec-management](https://github.com/oscarrenalias/skill-spec-management).