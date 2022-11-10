//
//  Created by Mark Battistella
//	@markbattistella
//

import Ink
import Plot
import Publish
import Files

// MARK: - create the plugin
public extension Plugin {

	enum Icon {
		case link
		case hash
		case bookmark
		case bookmarkFilled
		case dot
		case dotFilled
		case flame
		case heart
		case heartFilled
		case external
		case northStar
		case book
		case star
		case starFilled
	}


	// -- plugin for users
	static func addHeadingAnchors(upto level: Int = 6, icon: Icon = .bookmark, addCSS: Bool = true, path: Path = "") -> Self {

		// -- return the plugin
		return Plugin(name: "HeadingAnchors") { context in

			// -- write the css file
			if addCSS {
				let cssFile = try context.createOutputFile(at: "\(path)/heading-anchors.css")
				try cssFile.write(extraComponentsCssFile())
			}

			// -- add them to the plugins
			context.markdownParser.addModifier(
				.addAnchors(upto: level, icon: getSVGPaths(from: icon))
			)
		}
	}

	// -- switch the icon for the compiled version
	static private func getSVGPaths(from icon: Icon) -> [SVGPaths] {
		switch icon {
			case .link:
				return [.link1, .link2]
			case .hash:
				return [.hash]
			case .bookmarkFilled:
				return [.bookmarkFilled]
			case .dot:
				return [.dot]
			case .dotFilled:
				return [.dotFilled]
			case .flame:
				return [.flame]
			case .heart:
				return [.heart]
			case .heartFilled:
				return [.heartFilled]
			case .external:
				return [.linkExternal1, .linkExternal2]
			case .northStar:
				return [.northStar]
			case .book:
				return [.book1, .book2]
			case .starFilled:
				return [.starFilled]
			case .bookmark:
				return [.bookmark]
			case .star:
				return [.star]
		}
	}
}


// MARK: - create the modifiers
public extension Modifier {

	internal static func addAnchors(upto level: Int, icon: [SVGPaths], css: String? = nil) -> Self {
		Modifier(target: .headings) { html, markdown in
			return HeadingAnchors()
				.add(upto: level, icon: icon, html: html, markdown: markdown)
		}
	}
}


// MARK: - custom CSS file
fileprivate func extraComponentsCssFile() -> String {
	return try! File(path: #filePath)
		.parent?
		.file(named: "Support/heading-anchors.css")
		.readAsString() as! String
}
