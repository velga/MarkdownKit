//
//  MarkdownItalic.swift
//  Pods
//
//  Created by Ivan Bruel on 18/07/16.
//
//
import Foundation

open class MarkdownItalic: MarkdownCommonElement {
    fileprivate static let regex = "(\\s|^)(\\*|_)(?![\\*_\\s])(.+?)(?<![\\*_\\s])(\\2)"

    open var font: MarkdownFont?
    open var color: MarkdownColor?

    open var regex: String {
        return MarkdownItalic.regex
    }

    public init(font: MarkdownFont?, color: MarkdownColor? = nil) {
        self.font = font?.italic()
        self.color = color
    }

    public func match(_ match: NSTextCheckingResult, attributedString: NSMutableAttributedString) {
        // deleting trailing markdown
        attributedString.deleteCharacters(in: match.range(at: 4))
        // formatting string (may alter the length)
        // check if font is bold already:
        let stringAttributes = attributedString.attributes(at: match.range(at: 3).location, longestEffectiveRange: nil, in: match.range(at: 3))
        addAttributes(attributedString, range: match.range(at: 3))
        if let font = font,
            let stringFont = stringAttributes[.font] as? UIFont,
            stringFont.fontDescriptor.symbolicTraits.contains(.traitBold),
            let boldItalicFont = font.withTraits(.traitBold, .traitItalic) {
            attributedString.addAttributes([NSAttributedString.Key.font: boldItalicFont], range: match.range(at: 3))
        }
        // deleting leading markdown
        attributedString.deleteCharacters(in: match.range(at: 2))
    }
}
