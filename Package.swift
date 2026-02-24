// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "MapplsNearbyFinder",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "MapplsNearbyFinder",
            targets: ["MapplsNearbyFinderWrapper"])
    ],
    dependencies: [
        .package(url: "https://github.com/mappls-api/mappls-api-core-ios-distribution.git", from: "2.1.1"),
        .package(url: "https://github.com/mappls-api/mappls-api-kit-ios-distribution-base.git", from: "3.0.3")
    ],
    targets: [
        .binaryTarget(
            name: "MapplsNearbyFinder",
            url: "https://mmi-api-team.s3.amazonaws.com/mappls-sdk-ios/mappls-nearby-finder/MapplsNearbyFinder.xcframework-3.0.0.zip",
            checksum: "089b5974bc8fa456101766dadd1e4d1bf5c64c4f1ed579cb6d070779decd3f0a"
        ),
        .target(
            name: "MapplsNearbyFinderWrapper",
            dependencies: [
                "MapplsNearbyFinder",
                .product(name: "MapplsAPICore", package: "mappls-api-core-ios-distribution"),
                .product(name: "MapplsAPIKit", package: "mappls-api-kit-ios-distribution-base")
            ]
        ),
    ]
)
