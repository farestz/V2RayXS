# V2RayXL

macOS menu-bar GUI client for xray-core (proxy). Objective-C + AppKit (no Swift/SwiftUI). Abandoned upstream; this is an active fork.

## Tech Stack

- Language: Objective-C (AppKit/Cocoa), C (system helper)
- UI: AppKit with XIB files (no SwiftUI)
- Build: Xcode project (`V2RayXL.xcodeproj`)
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
xcodebuild -project V2RayXL.xcodeproj -target V2RayXL -configuration Debug

# Release build for current arch
bash build.sh

# Release build for specific arch
bash build.sh x86_64   # or arm64

# Output: build/Release/V2RayXL.app
```

### Build & Run

```bash
# Build debug and launch the app (kill existing instance first)
xcodebuild -project V2RayXL.xcodeproj -target V2RayXL -configuration Debug \
  && pkill -x V2RayXL 2>/dev/null; sleep 0.5 \
  && open build/Debug/V2RayXL.app

# View app logs in real time
log stream --predicate 'processImagePath ENDSWITH "V2RayXL"' --level debug
```

The app appears only in the menu bar (`LSUIElement = YES`), not in the Dock. After `open`, look for the menu bar icon to confirm it launched.

### Xcode build targets

- **V2RayXL** — main app target
- **v2rayxl_sysconf** — privileged C helper (system proxy / routing / TUN)

No test targets exist. Testing is manual: build and run the app.

## Key Architecture

```
AppDelegate                  — app lifecycle, NSTask for xray process, PAC server, config generation
ServerProfile                — model: VMess/VLESS server configs
ConfigWindowController       — main server config UI
AdvancedWindowController     — outbounds, routing rules, subscriptions
ConfigImporter               — parses VMess/VLESS links and subscription URLs
GCDWebServer                 — local HTTP server for PAC file (port 8071)
v2rayxl_sysconf              — C helper: system proxy settings, routing, TUN device
```

## Config Paths

- Preferences: `~/Library/Preferences/cenmrev.V2RayXL.plist`
- App support: `~/Library/Application Support/V2RayXL/`
- Generated xray config: `~/Library/Application Support/V2RayXL/config.json`
- PAC file: served locally on port 8071

## CI/CD

No CI/CD pipeline. Releases are built manually with `build.sh` and distributed as `.zip` via GitHub Releases. The script produces a universal or arch-specific `.app` bundle depending on arguments.

## Language

- Respond to the user **in Russian**
- Write code comments, commit messages, and `.md` files **in English**

## Workflow

### Opus — architecture, planning, and critical code
- Plan features (max iterations, precise changes down to files/functions/lines)
- Architectural decisions and trade-off analysis
- Review and refine plans before approval

**Opus writes code when:**
- Security-sensitive logic: cryptography, hash verification, certificate validation, credential handling, privilege escalation (`v2rayxl_sysconf`)
- Network security: TLS/mTLS configuration, proxy authentication, protocol parsing
- Complex algorithms: non-trivial data transformations, state machines, concurrency/synchronization
- System-level C code: the privileged helper, TUN device management, routing table manipulation
- Code that is hard to verify by reading — where a subtle bug causes silent data corruption or security bypass

### Sonnet — general implementation
- Write code following approved plans (UI, config generation, data models, standard AppKit patterns)
- Bulk find-and-replace across files
- Debug build errors (read xcodebuild logs, fix issues)
- Update documentation (README, CLAUDE.md)
- Update localization (.strings files)

**Sonnet writes code when:**
- UI and layout: window controllers, menu items, XIB wiring, cosmetic changes
- Data models and serialization: `ServerProfile`, JSON config generation, plist read/write
- Standard networking: subscription fetching, file downloads (non-auth)
- Glue code: AppDelegate lifecycle, NSTask orchestration, user defaults
- Anything where the approved plan already specifies exact changes line-by-line

### Haiku — mechanical subagent tasks
- **Git operations**: status, diff, log, commit, push
- **Codebase exploration**: `subagent_type=Explore` for grep/glob/read (saves Opus context from ingesting large files like AppDelegate.m, pbxproj)
- **Build verification**: run xcodebuild, report success/failure and errors only
- **Post-change checks**: grep for stale references, verify bundle ID in built .app

## Important Constraints

- **Objective-C only** — do not introduce Swift files
- **AppKit/XIB only** — do not introduce SwiftUI
- Do not add XCTest unless specifically asked
- Xray binary is NOT in git — must be downloaded separately via `dlcorex.sh`
- `v2rayxl_sysconf` helper needs elevated privileges for system proxy/routing changes
- TUN mode is experimental; can break routing if misused
- Minimum deployment target: macOS 10.12 (most APIs used are 10.13+)
- Separate builds required for x86_64 and arm64 (xray binary is arch-specific too)
- `LSUIElement = YES` — menu bar only app, no Dock icon
