# V2RayXS

macOS menu-bar GUI client for xray-core (proxy). Objective-C + AppKit (no Swift/SwiftUI). Abandoned upstream; this is an active fork.

## Tech Stack

- Language: Objective-C (AppKit/Cocoa), C (system helper)
- UI: AppKit with XIB files (no SwiftUI)
- Build: Xcode project (`V2RayXS.xcodeproj`)
- Frameworks: Cocoa, SystemConfiguration, libz
- Bundled: GCDWebServer (git submodule), Tun2socks.xcframework

## Build

### Prerequisites

- Xcode installed
- Xray core binary present at `V2RayX/v2ray` (download via `bash V2RayX/dlcorex.sh`)
- GCDWebServer submodule initialized: `git submodule update --init`

### Build commands

```bash
# Debug build
xcodebuild -project V2RayXS.xcodeproj -target V2RayXS -configuration Debug

# Release build for current arch
bash build.sh

# Release build for specific arch
bash build.sh x86_64   # or arm64

# Output: build/Release/V2RayXS.app
```

### Xcode build targets

- **V2RayXS** — main app target
- **v2rayx_sysconf** — privileged C helper (system proxy / routing / TUN)

No test targets exist. Testing is manual: build and run the app.

## Key Architecture

```
AppDelegate                  — app lifecycle, NSTask for xray process, PAC server, config generation
ServerProfile                — model: VMess/VLESS server configs
ConfigWindowController       — main server config UI
AdvancedWindowController     — outbounds, routing rules, subscriptions
ConfigImporter               — parses VMess/VLESS links and subscription URLs
GCDWebServer                 — local HTTP server for PAC file (port 8070)
v2rayx_sysconf               — C helper: system proxy settings, routing, TUN device
```

## Config Paths

- Preferences: `~/Library/Preferences/cenmrev.V2RayXS.plist`
- App support: `~/Library/Application Support/V2RayXS/`
- Generated xray config: `~/Library/Application Support/V2RayXS/config.json`
- PAC file: served locally on port 8070

## CI/CD

No CI/CD pipeline. Releases are built manually with `build.sh` and distributed as `.zip` via GitHub Releases. The script produces a universal or arch-specific `.app` bundle depending on arguments.

## Language

- Respond to the user **in Russian**
- Write code comments, commit messages, and `.md` files **in English**

## Important Constraints

- **Objective-C only** — do not introduce Swift files
- **AppKit/XIB only** — do not introduce SwiftUI
- Do not add XCTest unless specifically asked
- Xray binary is NOT in git — must be downloaded separately via `dlcorex.sh`
- `v2rayx_sysconf` helper needs elevated privileges for system proxy/routing changes
- TUN mode is experimental; can break routing if misused
- Minimum deployment target: macOS 10.12 (most APIs used are 10.13+)
- Separate builds required for x86_64 and arm64 (xray binary is arch-specific too)
- `LSUIElement = YES` — menu bar only app, no Dock icon
