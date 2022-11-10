// swift-tools-version:5.1

// HeadingAnchors plugin for Publish
// Copyright (c) Mark Battistella 2022
// MIT license - see LICENSE for details

import PackageDescription

let package = Package(
	name: "HeadingAnchors",
	products: [
		.library(
			name: "HeadingAnchors",
			targets: ["HeadingAnchors"]
		)
	],
	dependencies: [
		.package(url: "https://github.com/johnsundell/publish.git", from: "0.8.0")
	],
	targets: [
		.target(
			name: "HeadingAnchors",
			dependencies: ["Publish"]
		)
	]
)
