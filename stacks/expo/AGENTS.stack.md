## Stack Rules

- Expo with Expo Router and TypeScript. Keep `strict` on.
- Expo changes between SDK versions. Check the docs for the installed SDK before writing framework-specific code.
- Install packages that contain native code with `npx expo install` so their versions match the SDK.
- Prefer an Expo SDK module over a third-party library when both do the job.
- `EXPO_PUBLIC_` variables are bundled into the app and readable by anyone. Secrets stay on a server.
- Every screen must work on both iOS and Android. Respect safe areas and handle the keyboard.
- Design system sizes are density-independent units, not CSS pixels.
- Don't add custom native code or commit `ios/` and `android/` folders without asking.
- Use functional components, one component per job.

## Commands

Swap `npm` for the project's package manager if it uses a different one.

```sh
npm install        # Install dependencies
npx expo start     # Start the dev server
npx expo lint      # Lint
npx expo-doctor    # Check project health and dependency versions
npm run test       # Run tests (once a test runner is set up)
```
