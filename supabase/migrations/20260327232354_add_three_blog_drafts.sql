insert into stories (
  title,
  slug,
  subtitle,
  description,
  content,
  image_url,
  category,
  tags,
  company,
  published,
  featured
)
values
  (
    'Testing Gemma 3 270M on a Laptop: What Edge AI Actually Feels Like',
    'testing-gemma-3-270m-edge-ai-laptop',
    'I used a tiny Gemma 3 model in a local CLI workflow to see where on-device inference is practical and where it still falls short',
    'I built a small local test loop around Gemma 3 270M to measure the real tradeoffs of edge AI on a laptop: startup friction, latency, output quality, and where offline inference is genuinely useful.',
    'For the past few weeks, I have been hearing the same claim over and over again: the latest models are getting small enough to run on the edge, so the future of AI will be local by default. That is a compelling story. It is also vague. I wanted to know what it feels like when you stop talking about edge AI in the abstract and actually run a modern small model yourself on a laptop.

So I picked **Gemma 3 270M** as the anchor for the experiment and built the smallest possible workflow around it: a local CLI loop, a fixed set of prompts, and a simple habit of timing what happened instead of guessing. The goal was not to win a benchmark war. The goal was to answer a more practical question: when does on-device inference feel fast, cheap, private, and useful enough to change how you work?

## Why This Test Matters

The conversation around edge AI often jumps straight from model release notes to big predictions about offline assistants, personal agents, and private inference. What is usually missing is the middle layer: the builder experience. How much setup does it take? How quickly does the model respond? What kinds of tasks still break? And what is the quality bar you can realistically expect from a model that is small enough to carry onto a laptop?

I care about that middle layer because it is where most projects live. If you are building a real product, you do not need a model that is philosophically impressive. You need a model that can do a narrow job consistently, within clear hardware constraints, with enough speed that the workflow still feels alive.

## The Demo I Built

The companion project for this post lives outside this website repo, but the shape is intentionally small.

### Demo script

- Install the chosen local runtime and download a compact Gemma 3 checkpoint
- Run a fixed prompt set from the terminal instead of improvising one prompt at a time
- Record cold start behavior, average response time, and visible output failures
- Compare one local run against a stronger cloud model on the same tasks
- Save the terminal output and screenshots as the evidence base for the article

### Task loop

- Short summarization task
- Structured extraction task
- Tiny rewrite task
- One failure case that pushes the model past its comfort zone

That loop is enough to reveal the truth quickly. You do not need a giant benchmark harness to learn whether a model is useful. You need a repeatable set of tasks that maps to the actual job you care about.

## What Worked Better Than I Expected

The first pleasant surprise was responsiveness. Once the model was loaded, the loop felt immediate enough for lightweight tasks. That matters more than people admit. A small model does not have to be perfect to be valuable. It has to feel available.

The second surprise was privacy and focus. A local model changes the mental model of experimentation. You stop thinking about network calls, rate limits, and whether every tiny test should leave your machine. For note cleanup, structured extraction, and small drafting tasks, that shift alone is valuable.

The third surprise was how much easier product scoping becomes when the model is obviously constrained. A compact edge model forces discipline. You stop imagining a general-purpose assistant and start designing for one narrow workflow that can actually succeed.

## What Broke Fast

This is the part that matters most. Small edge models are not miniature frontier models. They are a different tool category.

- They lose coherence faster on multi-step reasoning tasks
- They are much easier to derail with underspecified prompts
- They struggle when the response format must be both long and precise
- They can look deceptively good on one-shot demos and then collapse on repeated use

That is why I would not position this class of model as an all-purpose copilot. I would position it as a local utility layer for bounded tasks with tight prompts, clear output formats, and modest context windows.

## Where Edge AI Is Already Worth It

There is a real sweet spot here.

- Offline note cleanup
- Private text classification
- Lightweight extraction from local files
- Embedded AI features where shipping every request to the cloud is too expensive or too slow
- Developer tools that benefit from instant local feedback without requiring deep reasoning

If your use case lives in that zone, local inference starts to feel less like a novelty and more like infrastructure.

## My Takeaway

The most interesting thing about edge AI right now is not that tiny models can do everything. It is that they can do enough. Enough to enable a new product shape. Enough to reduce cloud dependence for narrow features. Enough to make privacy-preserving workflows practical for small teams.

That is the bar I care about.

The next step for this experiment is straightforward: keep the workflow fixed, swap runtimes and quantizations, and see how much usability moves before quality collapses. That is where edge AI becomes a real builder story instead of another speculative trend line.',
    '/images/abstract-15-code-development.png',
    'Developer Tools',
    array['edge-ai', 'on-device', 'local-inference', 'model-testing'],
    'Google / Gemma',
    false,
    false
  ),
  (
    'How I Used Remotion to Turn Slides into Video with Animation and Audio',
    'remotion-slides-animation-audio-workflow',
    'A small Remotion setup let me treat slides like code, add motion with intent, and layer audio without reaching for a traditional video editor',
    'I used a lightweight Remotion project to turn slide-style layouts into a video workflow with transitions, timing control, and audio. The result felt closer to product building than editing.',
    'Most video tools are built around manual editing. That is fine when you are polishing a one-off clip. It is a bad fit when you want repeatability. I wanted a workflow where slides, timing, animation, and audio could all live in the same system, versioned like a real project instead of trapped inside a timeline I had to rebuild by hand.

That is what made **Remotion** click for me. It turns video into code, but more importantly, it turns motion into a system. Once I had a small setup project in place, I could treat each slide as a composition, make animation choices deliberately, and layer audio in a way that felt controlled instead of fragile.

## Why Remotion Felt Different

The strongest reason to use Remotion is not that it lets developers make videos. It is that it gives builders a repeatable production workflow.

When your visuals are assembled from components, timing values, and reusable patterns, a video stops being a one-time artifact. It becomes something you can iterate on with intention. You can swap copy, update layout rules, tighten pacing, and regenerate output without rebuilding the entire project from scratch.

That is especially useful for slide-based videos, which often sit in an awkward middle zone. They are too designed to be plain screen recordings, but too structured to justify a heavy editing workflow every time.

## The Small Setup Project

The companion project for this post lives outside this website repo, but the structure is simple enough to explain.

- One composition file controls the overall video timeline
- Each slide is represented as a reusable visual section with its own animation rules
- Shared motion values keep transitions consistent across the sequence
- Audio is layered on top with explicit timing instead of manual drag-and-drop editing
- Rendering happens through the project pipeline, so the output is reproducible

That structure matters because it turns the video into a system you can reason about.

## How I Approached Slide Animation

I did not want motion for the sake of motion. Slide videos get bad quickly when every element is moving simply because it can.

The useful pattern was to think in terms of emphasis.

### What motion should do

- Introduce a new idea
- Shift attention from one part of the frame to another
- Create rhythm between sections
- Support the voice of the content without overpowering it

That led me toward small directional moves, staged reveals, and transitions that helped the narrative breathe. The interesting lesson here is that code makes restraint easier. When animation values are explicit, you notice repetition faster and make cleaner decisions.

## Adding Audio Without Making the Workflow Fragile

Audio is where many simple video pipelines start to feel messy. In a manual editor, timing drift can turn even a short video into a cleanup job.

Remotion made this part easier because the audio layer could be handled with the same mindset as the visuals: define timing intentionally, line it up with the structure of the slides, and keep the project deterministic.

For this setup, the goal was not to create a complex audio stack. It was to make sure voice, music, and visual pacing were coordinated from the start.

- Bring audio in as part of the composition instead of as an afterthought
- Align each key visual beat to a known moment in the track or narration
- Keep transitions short enough that the audio still carries momentum
- Render from the same system every time so revisions do not introduce accidental drift

## What I Learned

The biggest shift was psychological. Once slides, motion, and audio lived inside a code workflow, I stopped thinking like an editor and started thinking like a systems designer.

That changed the quality of decisions.

- I made fewer decorative choices
- I reused structure more aggressively
- I could revise pacing without fearing that the whole project would unravel
- I could imagine turning one good setup into a repeatable content engine

This is why I think Remotion is so useful for creators who also like control. It does not just help you make a video. It helps you build a video workflow.

## Where I Would Use This Again

I would reach for this setup anytime the content has a repeatable visual pattern.

- Explainer videos built from slides and voiceover
- Product walkthroughs with timed callouts
- Social clips generated from a reusable template
- Founder videos where the structure matters more than cinematic editing
- Educational content that needs consistent pacing and branding

That is the real promise here. Remotion is not just a clever way to animate slides. It is a way to make motion, layout, and sound behave like parts of one system.',
    '/images/abstract-06-innovation.png',
    'Developer Tools',
    array['remotion', 'video-generation', 'slides', 'animation', 'audio'],
    'Remotion',
    false,
    false
  ),
  (
    'Long-Running Tasks Changed How I Think About Building with Agents',
    'long-running-tasks-agent-workflow-case-study',
    'The breakthrough was not better prompting. It was giving an agent enough structure to plan, build, verify, and only stop when the work was actually complete',
    'A one-shot prompt can generate code. A long-running task can stay with the problem until it has planned, built, checked, and repaired the output. That difference became obvious when I used the pattern to produce a working Pomodoro timer.',
    'For a long time, I treated prompt quality as the main variable in agent workflows. If the output was weak, I assumed the instruction was weak. If the result drifted, I assumed the prompt needed more detail. That mental model works up to a point. Then you hit a class of tasks that does not fail because the prompt is bad. It fails because the task itself requires iteration, state, and verification.

That is what changed my view of long-running tasks.

I saw it most clearly with a small Pomodoro timer build. The task was not complicated in the abstract. Build a timer, make it usable, test it, and return the finished output. A one-shot generation could produce fragments of that. A long-running workflow could actually carry the job from start to finish.

## The Real Difference

A long-running task is not just a slower prompt. It is a different control model.

The workflow matters because the system can hold onto the objective long enough to move through multiple stages.

- Understand the task
- Break the work into parts
- Build the first version
- Check whether the output actually works
- Fix what failed
- Stop only when the result is coherent enough to hand back

That sounds obvious when written down. In practice, it is the line between content generation and task completion.

## The Pomodoro Example

I like the Pomodoro timer example because it is visible, bounded, and honest. Either the timer works or it does not. Either the controls behave properly or they do not. Either the implementation survives testing or it does not.

That makes it a useful case study for agent workflows.

In my own run, the most interesting part was not the initial generation. It was what happened after. The system could keep the goal in view, inspect the result, run checks, and keep moving until it had something stable enough to return.

## Why One-Shot Prompting Breaks Down

One-shot prompting often collapses under exactly the conditions that matter in real work.

- The task has multiple dependent steps
- The output needs to be validated, not just generated
- An early mistake affects later decisions
- The system needs to revisit its own work
- Completion depends on a quality bar, not just an answer appearing on screen

That is why so many AI demos feel impressive for thirty seconds and disappointing in production. They optimize for first output, not finished work.

## What the Better Pattern Looks Like

The useful pattern is simple to describe, even if it is harder to execute well.

### A stronger workflow

- Start with a clear end state instead of only a feature request
- Let the system plan before it generates
- Keep checks close to the work so failures appear early
- Use verification as part of the loop, not as a final ceremony
- Treat the final answer as the end of a process, not the first draft

That pattern changes how you scope projects. You stop asking whether a model can produce an answer. You start asking whether the workflow can carry a task all the way to done.

## Why This Matters Beyond a Timer

The Pomodoro example is small, but the lesson scales.

If you want agents to do useful work, you need more than generation. You need persistence. You need intermediate checks. You need a way for the system to notice that something is off before a human discovers it later.

That is true for coding. It is true for research workflows. It is true for content systems. And it is especially true for any task where trust depends on the agent being able to inspect its own output before it declares victory.

## My Takeaway

The shift for me was subtle but important. I no longer think the core question is whether an agent can answer a prompt. The better question is whether the workflow gives the agent enough structure to finish a job.

That is why long-running tasks matter.

They turn the conversation away from clever one-liners and toward systems that can stay with the work long enough to improve it. That is where the real leverage starts to appear.',
    '/images/abstract-08-problem-solving.png',
    'Developer Tools',
    array['long-running-tasks', 'agent-workflows', 'testing', 'automation', 'pomodoro'],
    'Agent workflows',
    false,
    false
  )
on conflict (slug) do update
set
  title = excluded.title,
  subtitle = excluded.subtitle,
  description = excluded.description,
  content = excluded.content,
  image_url = excluded.image_url,
  category = excluded.category,
  tags = excluded.tags,
  company = excluded.company,
  published = excluded.published,
  featured = excluded.featured,
  updated_at = now();
