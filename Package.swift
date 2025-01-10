// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "swift-any-codable",
	platforms: [
		.iOS(.v13),
		.macOS(.v10_15),
		.tvOS(.v13),
	],
    products: [
        .library(
            name: "AnyCodable",
			targets: ["AnyCodable"]
		),
    ],
    targets: [
        .target(
			name: "AnyCodable"
		),
        .testTarget(
            name: "AnyCodableTests",
            dependencies: ["AnyCodable"]
        ),
    ]
)
