// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "sportmonks",
    platforms: [.macOS(.v10_15)],
    products: [
        .library(name: "Sportmonks", targets: ["Sportmonks"]),
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "4.40.0"),
        .package(url: "https://github.com/nihedr9/sportmonks-kit.git", .branch("master")),
//        .package(path: "../sportmonks-kit")
    ],
    targets: [
        .target(
            name: "Sportmonks", dependencies: [
                .product(name: "SportmonksKit", package: "sportmonks-kit"),
                .product(name: "Vapor", package: "vapor"),
            ]),
    ]
)
