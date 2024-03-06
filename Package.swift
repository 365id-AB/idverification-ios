// swift-tools-version:5.8

import PackageDescription

let package = Package(
    name: "IdVerification365id",
    defaultLocalization: "en",
    platforms: [.iOS(.v14)],
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
            url: "https://github.com/iProov/ios/releases/download/11.0.3/iProov.xcframework.zip",
            checksum: "6da33ee7eb224083a0565d4d6a1663025e51d9677d536db93fe6ab8b39d783cf"
        ),
        .binaryTarget(
            name: "CaptureCore",
            url: "https://github.com/BlinkID/capture-ios/releases/download/v1.2.1/CaptureCore.xcframework.zip",
            checksum: "df75df5a1db125f129b26910774f4d34acd41ca0f4c96e7fc38b598b67c89b39"
        )
    ]
)
