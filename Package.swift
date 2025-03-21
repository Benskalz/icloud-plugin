// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "CapacitorIcloudDrive",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "CapacitorIcloudDrive",
            targets: ["IcloudDrivePlugin"])
    ],
    dependencies: [
        .package(url: "https://github.com/ionic-team/capacitor-swift-pm.git", from: "7.0.0")
    ],
    targets: [
        .target(
            name: "IcloudDrivePlugin",
            dependencies: [
                .product(name: "Capacitor", package: "capacitor-swift-pm"),
                .product(name: "Cordova", package: "capacitor-swift-pm")
            ],
            path: "ios/Sources/IcloudDrivePlugin"),
        .testTarget(
            name: "IcloudDrivePluginTests",
            dependencies: ["IcloudDrivePlugin"],
            path: "ios/Tests/IcloudDrivePluginTests")
    ]
)