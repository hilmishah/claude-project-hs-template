## Stack Rules

- Next.js App Router with TypeScript. Keep `strict` on. No `any` without a stated reason.
- Next.js changes between versions. Before writing framework-specific code, check the docs for the installed version (bundled under `node_modules/next/dist/docs/` when present) instead of relying on memory.
- Server Components by default. Add `"use client"` only where a component needs state, effects or browser APIs.
- Fetch data on the server. Make changes through Server Actions or route handlers.
- Only `NEXT_PUBLIC_` variables reach the browser. Never put a secret behind that prefix.
- Style with Tailwind using the design system's tokens. No one-off hex values.
- Use functional components, one component per job.

## Commands

Swap `npm` for the project's package manager if it uses a different one.

```sh
npm install     # Install dependencies
npm run dev     # Run the dev server
npm run build   # Build for production
npm run lint    # Lint
npm run test    # Run tests (once a test runner is set up)
```
