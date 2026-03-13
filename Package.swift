// swift-tools-version:5.8

import PackageDescription

let package = Package(
    name: "IdVerification365id",
    defaultLocalization: "en",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "IdVerification365id",
            targets: [
                "IdVerification365id",
                "iProov",
                "CaptureCore"
            ]
        )
    ],
    targets: [
        .binaryTarget(
            name: "IdVerification365id",
            path: "IdVerification365id.xcframework.zip"
        ),
        .binaryTarget(
            name: "iProov",
            url: "https://github.com/iProov/ios/releases/download/13.1.1/iProov.xcframework.zip",
            checksum: "42d0049ff3e4f9844aff1c7235c1f5955023cd8e6016c8a44e46fef4c9a5a73a"
        ),
        .binaryTarget(
            name: "CaptureCore",
            url: "https://github.com/BlinkID/capture-ios/releases/download/v1.4.3/CaptureCore.xcframework.zip",
            checksum: "eb6419720e6ec3fabea9e80036b589ebd8c6ef4ad65306362f1ec194104cd97f"
        )
    ]
)
