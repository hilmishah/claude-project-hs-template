## Stack Rules

- Electron with TypeScript, split into main, preload and renderer. Keep each piece of code in the process it belongs to.
- Electron changes between versions. Check the docs for the installed version before writing framework-specific code.
- Every window uses `contextIsolation: true`, `nodeIntegration: false` and `sandbox: true`.
- The renderer never touches Node or Electron APIs directly. Expose a small, named API through `contextBridge` in the preload script, and never expose `ipcRenderer` itself.
- Treat every IPC message as untrusted. Validate its arguments in the main process handler.
- Load only local content or trusted HTTPS origins, and set a Content Security Policy.
- Open external links in the system browser after checking the URL. Don't navigate the app window to them.
- Secrets stay in the main process. Never send them to the renderer.

## Commands

```sh
npm install        # Install dependencies
npm run [dev]      # Run the app in development
npm run [build]    # Build and package the app
npm run test       # Run tests (once a test runner is set up)
```
