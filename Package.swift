// swift-tools-version:5.3

import PackageDescription

let package = Package(
  name: "ToastUI",
  platforms: [.iOS(.v14), .tvOS(.v14), .macOS(.v11)],
  products: [
    .library(
      name: "ToastUI",
      targets: ["ToastUI"]
    )
  ],
  targets: [
    .target(
      name: "ToastUI"
    )
  ]
)
