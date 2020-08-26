BUILD_DIR="Build"

# Build SDK for simulator
xcodebuild archive \
    -verbose \
    -project "PartnerApp.xcodeproj" \
    -scheme "YourSDK" \
    -configuration "Release" \
    -destination "generic/platform=iOS Simulator" \
    -archivePath "${BUILD_DIR}/SDK-iOS-Simulator" \
    SKIP_INSTALL=NO \
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES  \
    EXCLUDED_ARCHS=arm64
    

# Build SDK for device
xcodebuild archive \
    -project "PartnerApp.xcodeproj" \
    -scheme "YourSDK" \
    -configuration "Release" \
    -destination "generic/platform=iOS" \
    -archivePath "${BUILD_DIR}/SDK-iOS" \
    SKIP_INSTALL=NO \
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES 

# Generate combined XCFramework
xcodebuild -create-xcframework \
    -framework "${BUILD_DIR}/SDK-iOS-Simulator.xcarchive/Products/Library/Frameworks/YourSDK.framework" \
    -framework "${BUILD_DIR}/SDK-iOS.xcarchive/Products/Library/Frameworks/YourSDK.framework" \
    -output "${BUILD_DIR}/YourSDK.xcframework"
