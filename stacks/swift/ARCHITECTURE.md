# Architecture

## 1. System Overview

SwiftUI views → view models / observable state → services (networking, persistence) → [Backend and external services]

- **Platforms:** [e.g. iOS, macOS]
- **Minimum OS version:** [e.g. iOS 18]

## 2. Tech Stack

| Area         | Tool                                   |
|--------------|----------------------------------------|
| Language     | Swift                                  |
| UI           | SwiftUI                                |
| Concurrency  | async/await, actors                    |
| Data         | [e.g. SwiftData, or files on disk]     |
| Networking   | URLSession                             |
| Dependencies | Swift Package Manager                  |
| Auth         | [e.g. Sign in with Apple, if any]      |
| Payments     | [e.g. StoreKit, if any]                |
| Testing      | [Swift Testing or XCTest]              |
| Distribution | [e.g. TestFlight, App Store]           |

## 3. Project Structure

```
MyApp/
├ MyApp.xcodeproj
├ MyApp/
│ ├ App/          # App entry point, root scene, app-wide state
│ ├ Features/     # One folder per feature: its views and view models
│ ├ Core/         # Models, services, shared views and extensions
│ └ Resources/    # Asset catalog, localisations
├ MyAppTests/     # Unit tests
└ docs/           # Project documentation
```

## 4. Data Flow

1. The user interacts with a SwiftUI view
2. The view calls its view model or updates observable state
3. The view model asks a service in `Core/` to fetch or save data
4. The service returns the result asynchronously
5. State changes on the main actor and SwiftUI re-renders

## 5. Scalability

- Keep each feature in its own folder under `Features/`
- Keep networking and persistence behind services in `Core/`, not inside views
- Don't add new packages or services without updating this file
