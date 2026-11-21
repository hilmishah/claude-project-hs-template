# Architecture

## 1. System Overview

Renderer (UI, a web page) → preload script (a small API exposed with `contextBridge`) → main process (windows, files, OS, network) → [External services]

## 2. Tech Stack

| Area         | Tool                                                  |
|--------------|-------------------------------------------------------|
| Language     | TypeScript                                            |
| Runtime      | Electron                                              |
| Renderer UI  | [e.g. React with Vite]                                |
| Tooling      | [e.g. Electron Forge, electron-vite, electron-builder] |
| Data         | [Local storage or database, and any backend]          |
| Auth         | [Auth provider, if any]                               |
| Updates      | [Auto-update mechanism, if any]                       |
| Testing      | [e.g. Vitest, Playwright]                             |
| Distribution | [Platforms and how builds are signed and shipped]     |

## 3. Project Structure

```
my-app/
├ src/
│ ├ main/       # Main process: windows, app lifecycle, IPC handlers, OS access
│ ├ preload/    # Preload scripts: the API exposed to the renderer
│ └ renderer/   # UI, running as an ordinary web page
├ resources/    # Icons and packaged assets
└ docs/         # Project documentation
```

## 4. Data Flow

1. The user interacts with the renderer
2. The renderer calls a function exposed by the preload script
3. The preload script forwards the call to the main process over IPC
4. The main process validates the arguments and does the work (files, network, OS)
5. The result returns to the renderer and the UI updates

## 5. Scalability

- Keep one IPC channel per job, with a clear name
- Keep OS and file access in the main process, never in the renderer
- Don't add new tools or services without updating this file
