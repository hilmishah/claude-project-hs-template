# AI-ready project template

A starting structure for any new project that gives AI coding tools (Claude Code, Cursor, Codex) a written brief to check before they write code. It is stack-neutral, with presets for Next.js, Swift, Expo and Electron.

It combines two ideas:

- **Four plain-text files** that tell the AI what you're building, how it should look, how it's built, and the rules to follow.
- **Four working principles** that curb the most common AI coding mistakes: think before coding, simplicity first, surgical changes, goal-driven execution.

## What's inside

```
├ AGENTS.md              # Rules the AI follows every session, including the four principles
├ CLAUDE.md              # One line, @AGENTS.md, so Claude Code loads the same file
├ docs/
│ ├ PRD.md               # What you're building and why
│ ├ DESIGN_SYSTEM.md     # How it should look
│ └ ARCHITECTURE.md      # How it's built
├ stacks/                # Presets: nextjs, swift, expo, electron
└ scripts/apply.sh       # Applies the template and a preset to a project
```

Each preset supplies a pre-filled `ARCHITECTURE.md` and a block of stack rules and commands for `AGENTS.md`.

## Use it

Pick `nextjs`, `swift`, `expo`, `electron`, or `generic` for no preset.

### On a project your framework tool generated

Most framework tools (`create-next-app`, `create-expo-app`, Xcode) want to create the project folder themselves, so generate the project first and then add the template to it.

```sh
npx create-next-app@latest my-app
git clone https://github.com/hilmishah/claude-project-hs-template.git
claude-project-hs-template/scripts/apply.sh nextjs my-app
```

Files that already exist in the project are kept, and the script lists them. If the generator wrote its own `AGENTS.md` or `CLAUDE.md` (recent versions of `create-next-app` do), either merge by hand or rerun with `--force` to replace them with the template's versions.

### As a new repo from this template

```sh
gh repo create my-app --template hilmishah/claude-project-hs-template --private --clone
cd my-app
scripts/apply.sh swift --in-place
```

`--in-place` applies the preset, then removes the template's own files (`stacks/`, `scripts/`, `LICENSE`) and replaces this README with a short project stub.

## Fill it in

Write the files in this order, since each builds on the one before: `PRD.md`, `DESIGN_SYSTEM.md`, `ARCHITECTURE.md`, then `AGENTS.md`.

The quickest way is to let your AI tool draft them. The script prints this prompt when it finishes:

```
I'm building [describe your app in 2 to 3 sentences]. It's for [who it's for].
Fill in the bracketed parts of docs/PRD.md, docs/DESIGN_SYSTEM.md,
docs/ARCHITECTURE.md and AGENTS.md. Keep the structure and headings.
Ask me up to 5 questions first if anything important is unclear.
```

Read what comes back and correct anything that's wrong. Ten minutes of editing here saves hours of fixing later.

## Day to day

- **Starting a session:** Claude Code reads `CLAUDE.md`, which imports `AGENTS.md`. Cursor and Codex read `AGENTS.md` directly.
- **The docs folder:** the three files in `docs/` are read when `AGENTS.md` tells the AI to read them. To point at one for a task, mention it in your prompt, for example `@docs/PRD.md`.
- **Keep them current:** when the stack, features or design change, update the matching file. Out-of-date docs are worse than no docs.
- **Add rules as you go:** if you correct the AI on the same thing twice, add a line to `AGENTS.md`.
- **Keep them short:** bullet points beat paragraphs, and exact values (hex codes, tool names) beat adjectives.

## Add your own preset

Create `stacks/<name>/` with two files:

- `ARCHITECTURE.md`: a complete, pre-filled copy of `docs/ARCHITECTURE.md` for that stack.
- `AGENTS.stack.md`: a `## Stack Rules` section and a `## Commands` section. The script places it between the `stack:begin` and `stack:end` markers in `AGENTS.md`.

Then run `scripts/apply.sh <name> <target-dir>`.

## Going further

Once the four files are working, larger projects often add `CODE_STYLE.md` (formatting and naming), `SECURITY.md` (auth, permissions and data handling) and `TESTING.md` (what needs testing and how) to `docs/`, each with a line in `AGENTS.md` saying when to read it.

## Credits

- The four-file structure and starter templates are adapted from "The 4 Files That Make AI Build Your App Properly", a free guide by Max Johnson (@maxjohnscn).
- The Working Principles in `AGENTS.md` come from [andrej-karpathy-skills](https://github.com/forrestchang/andrej-karpathy-skills) by forrestchang (MIT), derived from Andrej Karpathy's observations on LLM coding pitfalls.

## License

[MIT](LICENSE)
