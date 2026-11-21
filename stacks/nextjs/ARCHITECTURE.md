# Architecture

## 1. System Overview

Browser → Next.js app (Server Components, Server Actions, route handlers) → [Database and external services]

## 2. Tech Stack

| Area         | Tool                                      |
|--------------|-------------------------------------------|
| Language     | TypeScript                                |
| Framework    | Next.js (App Router), React               |
| Styling      | Tailwind CSS                              |
| Data         | [e.g. Postgres via an ORM]                |
| Auth         | [Auth provider, if any]                   |
| Payments     | [Payments provider, if any]               |
| Analytics    | [Analytics tool, if any]                  |
| Testing      | [e.g. Vitest, Playwright]                 |
| Distribution | [e.g. Vercel]                             |

## 3. Project Structure

```
my-app/
├ app/          # Routes, layouts and route handlers
├ components/   # Reusable UI components
├ lib/          # Utilities, config and server-side helpers
├ hooks/        # Custom React hooks
├ types/        # Shared TypeScript types
├ public/       # Images and static files
└ docs/         # Project documentation
```

If the project uses a `src/` folder, everything except `public/` and `docs/` lives inside it.

## 4. Data Flow

1. A request hits a route in `app/`
2. Server Components fetch the data they need on the server
3. Changes go through Server Actions or route handlers, which validate input and write to the data store
4. Client Components handle interactivity in the browser
5. The affected route re-renders and the UI updates

## 5. Scalability

- Keep features in separate, modular components
- Keep data access in `lib/`, not scattered through components
- Don't add new tools or services without updating this file
