I want to build 

(high-level overview)

It has the following features: 

(features)

Use Claude AskInterviewQuestion (or if you are not claude, a simulation of that process) to interview me in depth and detail to create a complete project specification.  

If (high-level overview) and (features) haven't been replaced with specifics, ask the user those two questions first.

At each step, ask one focused, non‑trivial question with clear numbered answer options when appropriate.  Include an "other" option that lets users specify what'd they'd rather do or say they don't know what to do.

Ask detailed, non‑obvious questions about missing decisions, edge cases, implementation details, requirements, architecture, UX, constraints, and tradeoffs. Keep asking until you are confident there is little ambiguity left and you could generate a comprehensive spec.

Then generate the spec as SPECIFICATION.md.  Break the implementation plan up into different phases, subphases, and tasks so that multiple coding agents can work on the project in parallel.  Make it clear if any phases, subphases, or tasks depend on others.  Only plan, don't write any code.

