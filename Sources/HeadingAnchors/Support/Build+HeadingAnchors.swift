//
//  Created by Mark Battistella
//	@markbattistella
//

import Foundation
import Publish
import Plot

final class HeadingAnchors {

	// MARK: - create the alert
	func add(upto level: Int, icon: [SVGPaths], html: String, markdown: Substring) -> String {

		// -- check the level is within 1-6
		if level < 1 || level > 6 {
			print("Your integers need to be within the 1-6 range")
			return html
		}

		// get the number of # tags
		var headingLevel: Int {
			if markdown.starts(with: "######") { return 6 }
			if markdown.starts(with: "#####") { return 5 }
			if markdown.starts(with: "####") { return 4 }
			if markdown.starts(with: "###") { return 3 }
			if markdown.starts(with: "##") { return 2 }
			if markdown.starts(with: "#") { return 1 }
			return 0
		}

		// -- check if within users range
		if headingLevel > level { return html }

		// -- create the anchor id
		var anchorID: String? {
			do {
				return try String(markdown).convertedToSlug()
			} catch {
				return nil
			}
		}

		// -- output node
		var headingNode: Node<HTML.BodyContext> {
			var body: Node<HTML.BodyContext> {
				.group(
					.unwrap(anchorID, { id in
						.group(
							.id(id),
							.a(.href("#\(id)"),
							   .createSVG(viewBox: "0 0 24 24", paths: icon)
							)

						)
					}),
					.span(.text(String(markdown.dropFirst(headingLevel + 1))))
				)
			}
			var headingNode: Node<HTML.BodyContext> {
				if headingLevel == 1 { return .h1(body) }
				if headingLevel == 2 { return .h2(body) }
				if headingLevel == 3 { return .h3(body) }
				if headingLevel == 4 { return .h4(body) }
				if headingLevel == 5 { return .h5(body) }
				if headingLevel == 6 { return .h6(body) }
				return .div(.text(String(markdown.dropFirst(headingLevel))))
			}
			return headingNode
		}

		// -- render it out
		return headingNode.render()
	}
}
