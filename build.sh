#!/bin/sh
# Builds all targets and runs tests.

DERIVED_DATA=${1:-/tmp/LayoutKit}
echo "Derived data location: $DERIVED_DATA";

    #-destination 'platform=iOS Simulator,name=iPhone 6,OS=8.4' \
    #-destination 'platform=iOS Simulator,name=iPhone 6 Plus,OS=8.4' \

set -o pipefail &&
rm -rf $DERIVED_DATA &&

# Run test on iOS
rm -rf $DERIVED_DATA &&
time xcodebuild clean test \
    -project LayoutKit.xcodeproj \
    -scheme LayoutKit-iOS \
    -sdk iphonesimulator10.3 \
    -derivedDataPath $DERIVED_DATA \
    -destination 'platform=iOS Simulator,name=iPhone 6,OS=9.3' \
    -destination 'platform=iOS Simulator,name=iPhone 6 Plus,OS=9.3' \
    -destination 'platform=iOS Simulator,name=iPhone 7,OS=10.3' \
    -destination 'platform=iOS Simulator,name=iPhone 7 Plus,OS=10.3' \
    OTHER_SWIFT_FLAGS='-Xfrontend -debug-time-function-bodies' \
    | tee build.log \
    | xcpretty &&
cat build.log | sh debug-time-function-bodies.sh &&

# Run test on MacOS
time xcodebuild clean test \
    -project LayoutKit.xcodeproj \
    -scheme LayoutKit-macOS \
    -sdk macosx10.12 \
    -derivedDataPath $DERIVED_DATA \
    OTHER_SWIFT_FLAGS='-Xfrontend -debug-time-function-bodies' \
    | tee build.log \
    | xcpretty &&
cat build.log | sh debug-time-function-bodies.sh &&

# Run test on tvOS
rm -rf $DERIVED_DATA &&
time xcodebuild clean test \
    -project LayoutKit.xcodeproj \
    -scheme LayoutKit-tvOS \
    -sdk appletvsimulator10.2 \
    -derivedDataPath $DERIVED_DATA \
    -destination 'platform=tvOS Simulator,name=Apple TV 1080p,OS=9.2' \
    -destination 'platform=tvOS Simulator,name=Apple TV 1080p,OS=10.2' \
    OTHER_SWIFT_FLAGS='-Xfrontend -debug-time-function-bodies' \
    | tee build.log \
    | xcpretty &&
cat build.log | sh debug-time-function-bodies.sh &&

# Test Cocopods, Carthage, Swift Package Management

# Build sample app with cocoapods
rm -rf $DERIVED_DATA &&
cd Example/ &&
pod install &&
time xcodebuild clean build \
    -workspace LayoutKitSampleApp.xcworkspace \
    -scheme LayoutKitSampleApp \
    -sdk iphonesimulator10.3 \
    -derivedDataPath $DERIVED_DATA \
    -destination 'platform=iOS Simulator,name=iPhone 6,OS=9.3' \
    -destination 'platform=iOS Simulator,name=iPhone 6 Plus,OS=9.3' \
    -destination 'platform=iOS Simulator,name=iPhone 7,OS=10.3' \
    -destination 'platform=iOS Simulator,name=iPhone 7 Plus,OS=10.3' \
    OTHER_SWIFT_FLAGS='-Xfrontend -debug-time-function-bodies' \
    | tee ../build.log \
    | xcpretty &&
cd .. &&
cat build.log | sh debug-time-function-bodies.sh
