// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "MapplsNearbyFinder",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "MapplsNearbyFinder",
            targets: ["MapplsNearbyFinder"]
        )
    ],
    targets: [
        .binaryTarget(
            name: "MapplsNearbyFinder",
            url: "https://mmi-api-team.s3.amazonaws.com/mappls-sdk-ios/mappls-nearby-ui/MapplsNearbyFinder.xcframework-3.0.1.zip",
            checksum: "1b88e0d2602c5df273982ba445741a64e14cb6a951058e5a752de47360928dc8"
        )
    ]
)
