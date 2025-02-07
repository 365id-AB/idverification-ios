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
            path: "IdVerification365id.xcframework"
        ),
        .binaryTarget(
            name: "iProov",
            url: "https://github.com/iProov/ios/releases/download/12.2.2/iProov.xcframework.zip",
            checksum: "8592a75818be86975f66bdc2a27759ccfb6a8740be1cbff20468626d306229ae"
        ),
        .binaryTarget(
            name: "CaptureCore",
            url: "https://github.com/BlinkID/capture-ios/releases/download/v1.4.3/CaptureCore.xcframework.zip",
            checksum: "eb6419720e6ec3fabea9e80036b589ebd8c6ef4ad65306362f1ec194104cd97f"
        )
    ]
)
