---
name: "performance-optimization-loop"
description: "Slow app or performance sprint: measure user journeys, optimize verified bottlenecks, and preserve proven gains."
status: proposal
version: "v1"
date: "2026-10-05T16:58:32.461Z"
---

# Performance Optimization Loop

Turn observed slowness into reproducible, measured improvements in the requested application. Use the user's article as a methodology, not as evidence of speedups in another app.

1. **Define the journey and scope.** Read repository instructions and existing telemetry. Select a high-impact journey using usage frequency and user-visible cost; when usage data is unavailable, label prioritization as an assumption. Define its initiating interaction and rendered, usable endpoint. Record the permitted environment and changes. Finish with a bounded journey and explicit correctness invariants.

2. **Establish a comparable baseline.** Reuse existing profiling and browser tooling before building instrumentation. Record commit, fixture size, device/runtime, network, cache state, sample count, and timing boundaries. Separate client, network, server, database, and third-party work. Use repeated timings and meaningful percentiles; distinguish controlled lab results from real-user monitoring. Finish with a reproducible baseline and the measurement's limitations.

3. **Find the bottleneck and validate the benchmark.** Trace the critical path for repeated requests, serial I/O, N+1 queries, unnecessary renders, main-thread tasks, layout shifts, and work before usability. Treat code observations as hypotheses until measured. Use counts such as database round trips, React commits, or DOM mutations when relevant; establish their relationship to latency before optimizing or gating them. Instruction counts suit controlled CPU hot paths, not whole network journeys. Finish with a reproducible bottleneck and a metric that reflects the selected user outcome.

4. **Run a focused optimization loop.** State the expected mechanism and measurable objective, then make a small maintainable change. Re-measure with equivalent conditions, fixtures, and functionality, alternating baseline and candidate runs where useful to control drift. Report absolute and relative changes plus variability; separate estimates from observations. Retain demonstrated wins and revise or revert ineffective experiments without disturbing unrelated user changes. Finish with measured evidence or a clearly rejected hypothesis.

5. **Preserve the user experience.** Verify invariants appropriate to the journey: saved input, scoring, deadlines, access boundaries, freshness, and accessibility. Exercise actual failure cases with targeted checks rather than implementation-mirroring tests. For perceptible changes, provide before/after screenshots or recordings and explain the tradeoff. For risky rollouts, use the application's existing flag mechanism with a retirement condition. Finish with correctness results and disclosed unverified behavior.

6. **Scale only independent work.** When delegation is requested or authorized, assign narrow journey or benchmark investigations with explicit output and disjoint write scope. Coordinate shared schemas, dependencies, and integration files centrally. Expand after a single loop produces credible results, not by creating overlapping projects. Finish with integrated results measured against the same baseline.

7. **Verify delivery and retain the win.** Follow the session's existing merge and deployment authorization; this skill grants no new production authority. After an authorized rollout, compare field latency and errors over a stated window and follow the agreed rollback path if necessary. Label local, reviewed, merged, deployed, and field-verified states separately. Protect proven improvements using stable, relevant budgets; use controlled scheduled measurements for noisy timings rather than brittle PR gates. Lower a ceiling only with repeatable evidence, and explain justified budget increases. Finish with an accurate delivery state and an appropriate regression check.

8. **Continue with judgment and report.** Re-profile the same journey after a win, since the bottleneck may move. Continue within authorized scope while the next opportunity has meaningful impact; stop or change direction when gains fall within noise or maintenance cost exceeds benefit. Report journey, baseline and candidate, measurement conditions, checks, tradeoffs, changed files, delivery state, and next opportunity. Finish with actionable evidence, not an unsupported speedup claim.

## Measurement choices

- Interaction latency: user action to usable result; server response time alone is insufficient.
- Rendering: commits, long tasks, and region-specific layout shifts; whole-page CLS can hide visible local movement.
- Data access: query counts and time, repeated lookups, and serial round trips; preserve consistency when batching.
- Saving/submission: distinguish durable receipt from downstream grading or processing; retain failure and retry semantics.
- CI: keep fast correctness checks independent of expensive journey benchmarks so one failure does not conceal other signals.

## Source

Adapted from the user-supplied article, [How we made claude.ai 3x faster in two weeks](https://claude.dev/blog/how-we-made-claude-ai-faster/). Its reported gains are not targets or guarantees for the application using this skill.
