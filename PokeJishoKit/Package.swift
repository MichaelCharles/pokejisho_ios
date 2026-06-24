// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "PokeJishoKit",
    platforms: [.iOS(.v17), .macOS(.v14)],
    products: [
        .library(name: "PokeJishoKit", targets: ["PokeJishoKit"]),
    ],
    targets: [
        .target(
            name: "PokeJishoKit",
            resources: [.process("Resources")]
        ),
        .testTarget(
            name: "PokeJishoKitTests",
            dependencies: ["PokeJishoKit"]
        ),
    ]
)
