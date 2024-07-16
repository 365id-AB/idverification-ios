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
            url: "https://github.com/iProov/ios/releases/download/11.1.1/iProov.xcframework.zip",
            checksum: "6a4b85f2e10a6819d97fffaa0719702e9a885db3ef0e4ab75cfec7a05d854af4"
        ),
        .binaryTarget(
            name: "CaptureCore",
            url: "https://github.com/BlinkID/capture-ios/releases/download/v1.3.1/CaptureCore.xcframework.zip",
            checksum: "31a6ded66b16e3c3d7fb75584ed039626ae6d7762d9058f9fea375aa9c5569e2"
        )
    ]
)
