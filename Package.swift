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
            url: "https://github.com/iProov/ios/releases/download/12.0.0/iProov.xcframework.zip",
            checksum: "f1eb0a3c585ea677401054943e34b15b16d21e45c1b1bdc8654dba438e02e612"
        ),
        .binaryTarget(
            name: "CaptureCore",
            url: "https://github.com/BlinkID/capture-ios/releases/download/v1.4.1/CaptureCore.xcframework.zip",
            checksum: "09defaa5ca73872e1cbf115782bf97a37c40ac775742e33ed88827487a31e6ac"
        )
    ]
)
