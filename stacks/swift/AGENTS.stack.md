## Stack Rules

- Swift with SwiftUI. Drop to UIKit or AppKit only when SwiftUI cannot do the job, and say so.
- Check the project's minimum OS version before using an API. Don't raise the deployment target without asking.
- Use async/await and structured concurrency in new code. Update UI state on the main actor.
- No force unwraps (`!`) or `try!` outside tests and previews.
- Use SF Symbols for icons and system text styles so Dynamic Type works. Design system sizes are points.
- Take colours from the asset catalog, named after the design system. Support light and dark appearance.
- Keep secrets out of source and `Info.plist`. Use an untracked `.xcconfig` for build-time config and the Keychain for user credentials.
- Add dependencies through Swift Package Manager. Avoid hand-editing `project.pbxproj` unless there is no other way.

## Commands

```sh
xcodebuild -scheme [Scheme] -destination '[destination]' build   # Build
xcodebuild -scheme [Scheme] -destination '[destination]' test    # Run tests
swift build && swift test                                        # If this is a Swift package
```
