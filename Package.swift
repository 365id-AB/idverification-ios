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
            url: "https://github.com/BlinkID/capture-ios/releases/download/v1.1.1/CaptureCore.xcframework.zip",
            checksum: "e9c1dea0214daf83f10222ceea9b098b9be62354dbf7d364f839ee47e6ff18cb"
        )
    ]
)
