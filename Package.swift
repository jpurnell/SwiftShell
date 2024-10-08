// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftShell",
    products: [
        // A little package to enable calling shell commands from within a Swift CLI.
        .library(
            name: "SwiftShell",
            targets: ["SwiftShell"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "SwiftShell"),
        .testTarget(
            name: "SwiftShellTests",
            dependencies: ["SwiftShell"]
        ),
    ]
)
