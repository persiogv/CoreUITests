// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CoreUITests",
    platforms: [
        .iOS(.v9)
    ],
    products: [
        .library(
            name: "CoreUITests",
            targets: ["CoreUITests"]),
    ],
    dependencies: [
        .package(url: "https://github.com/httpswift/swifter.git", from: "1.4.7"),
    ],
    targets: [
        .target(
            name: "CoreUITests",
            dependencies: ["Swifter"]),
        .testTarget(
            name: "CoreUITestsTests",
            dependencies: ["CoreUITests"]),
    ]
)
