// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "micro-batcher",
    platforms: [
        .macOS(.v11)
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.5.0"),
        .package(url: "https://github.com/latorante/interview-upguard-micro-batching-library", .branch("main"))
    ],
    targets: [
        .executableTarget(
            name: "micro-batcher",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .product(name: "MicroBatching", package: "interview-upguard-micro-batching-library")
            ]),
    ]
)
