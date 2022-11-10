//
//  Created by Mark Battistella
//	@markbattistella
//

import Plot
import Foundation

extension Node where Context : HTML.BodyContext {
	// -- svg elements
	static func svg(_ nodes: Node<Context>...) -> Node {
		.element(named: "svg", nodes: nodes)
	}

	static func path(_ nodes: Node<Context>...) -> Node {
		.element(named: "path", nodes: nodes);
	}

	static func createSVG(viewBox: String, paths: [SVGPaths]) -> Node {
		return .svg(.attribute(named: "viewBox", value: viewBox),
					.forEach(paths, { path in
							.path(.attribute(named: "d", value: path.rawValue))
					})
		)
	}
}
