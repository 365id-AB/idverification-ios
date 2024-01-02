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
            url: "https://github.com/iProov/ios/releases/download/11.0.2/iProov.xcframework.zip",
            checksum: "66494a4fabf578a31cd62ee0c63af2f35526fcbda908e5dc72761f52a050d638"
        ),
        .binaryTarget(
            name: "CaptureCore",
            url: "https://github.com/BlinkID/capture-ios/releases/download/v1.2.1/CaptureCore.xcframework.zip",
            checksum: "df75df5a1db125f129b26910774f4d34acd41ca0f4c96e7fc38b598b67c89b39"
        )
    ]
)
