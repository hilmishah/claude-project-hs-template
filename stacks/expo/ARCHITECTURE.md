# Architecture

## 1. System Overview

Mobile app (iOS / Android) built with Expo → [Backend API] → [Database and external services]

## 2. Tech Stack

| Area         | Tool                                        |
|--------------|---------------------------------------------|
| Language     | TypeScript                                  |
| Framework    | Expo, React Native                          |
| Navigation   | Expo Router                                 |
| Styling      | [e.g. StyleSheet, or NativeWind]            |
| Data         | [Backend, and any on-device storage]        |
| Auth         | [Auth provider, if any]                     |
| Payments     | [Payments provider, if any]                 |
| Analytics    | [Analytics tool, if any]                    |
| Testing      | [e.g. Jest with React Native Testing Library] |
| Distribution | [e.g. EAS Build, App Store, Google Play]    |

## 3. Project Structure

```
my-app/
├ app/          # Routes and layouts (Expo Router)
├ components/   # Reusable UI components
├ hooks/        # Custom React hooks
├ lib/          # Utilities, API clients and config
├ assets/       # Images and fonts
└ docs/         # Project documentation
```

If the project uses a `src/` folder, everything except `assets/` and `docs/` lives inside it.

## 4. Data Flow

1. The user interacts with a screen in `app/`
2. The screen calls a hook or a client in `lib/`
3. The request goes to the backend, which validates it and stores the data
4. The response returns to the app
5. State updates and the screen re-renders

## 5. Scalability

- Keep features in separate, modular components
- Keep API calls in `lib/`, not scattered through screens
- Don't add new packages or services without updating this file
