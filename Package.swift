// swift-tools-version:5.3

import PackageDescription

let package = Package(
  name: "ToastUI",
  platforms: [.iOS(.v13), .tvOS(.v13)],
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
