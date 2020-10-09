# flutter

## Set environment variables
```bash
export PATH="$PATH:$HOME/flutter/bin"
export PATH="$PATH:$HOME/flutter/.pub-cache/bin"
export PATH="$PATH:$HOME/flutter/bin/cache/dart-sdk/bin"
export PATH="$PATH:$HOME/.pub-cache/bin"
```

## Set flutter config
- Enable linux desktop
```
flutter config — enable-linux-desktop
```

## Install
- Install protoc plugin
```bash
pub global activate protoc_plugin
```

## Command
### Commonly used
- Show information about the installed tooling
```bash
flutter doctor
```
- Open Simulator
```bash
open -a Simulator
```
- Create a new Flutter project
```bash
flutter create $project_name
```
- Format one or more dart files
```bash
flutter format
```
- List all connected devices
```bash
flutter devices
```
- Run your Flutter app on an attached device
```bash
flutter run
```
- Commands for install Flutter packages
```bash
flutter pub get
```

### Others
- Analyze the project's Dart code
```bash
flutter analyze
```
- Assemble and build flutter resources
```bash
flutter assemble
```
- Attach to a running application
```bash
flutter attach
```
- Output command line shell completion setup scripts
```bash
flutter bash-completion
```
- Flutter build commands
```bash
flutter build
```
- List or switch flutter channels
```bash
flutter channel
```
- Delete the build/ and .dart_tool/ directories
```bash
flutter clean
```
- Configure Flutter settings
```bash
flutter config
```
- Runs Flutter Driver tests for the current project
```bash
flutter drive
```
- List, launch and create emulators
```bash
flutter emulators
```
- run code generators
```bash
flutter generate
```
- Display help information for flutter
```bash
flutter help
```
- Install a Flutter app on an attached device
```bash
flutter install
```
- Show log output for running Flutter apps
```bash
flutter logs
```
- Moves host apps from generated directories to non-generated directories so that they can be edited by - developers
```bash
flutter make-host-app-editable
```
- Populates the Flutter tool's cache of binary artifacts
```bash
flutter precache
```
- Commands for managing Flutter packages
```bash
flutter pub
```
- Take a screenshot from a connected device
```bash
flutter screenshot
```
- Run Flutter unit tests for the current project
```bash
flutter test
```
- Upgrade your copy of Flutter
```bash
flutter upgrade
```
- List or switch flutter versions
```bash
flutter version
```

## Issues
```bash
[!] Connected device
    ! Error: Could not locate device support files. This iPhone 7 (Model 1660,
      1778, 1779, 1780) is running iOS 13.7 (17H35), which may not be supported
      by this version of Xcode. An updated version of Xcode may be found on the
      App Store or at developer.apple.com. (code 601)
```
https://github.com/filsv/iPhoneOSDeviceSupport