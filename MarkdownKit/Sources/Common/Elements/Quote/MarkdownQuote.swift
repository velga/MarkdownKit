//
//  MarkdownQuote.swift
//  Pods
//
//  Created by Ivan Bruel on 18/07/16.
//
//
import Foundation

open class MarkdownQuote: MarkdownLevelElement {

  fileprivate static let regex = "^(\\>)\\s*(.+)$"

  open var maxLevel: Int
  open var fontIncrease: CGFloat
  open var font: MarkdownFont?
  open var color: MarkdownColor?
  open var backgroundColor: MarkdownColor?

  open var regex: String {
    let level: String = maxLevel > 0 ? "\(maxLevel)" : ""
    return String(format: MarkdownQuote.regex, level)
  }

  public init(maxLevel: Int = 0, fontIncrease: CGFloat = 0, font: MarkdownFont? = nil, color: MarkdownColor? = nil, backgroundColor: MarkdownColor? = nil) {
    self.maxLevel = maxLevel
    self.fontIncrease = fontIncrease
    self.font = font
    self.color = color
    self.backgroundColor = backgroundColor
  }
  
  public func attributesForLevel(_ level: Int) -> [NSAttributedString.Key : AnyObject] {
    var codeAttributes = attributes
    
    color.flatMap { codeAttributes[NSAttributedString.Key.foregroundColor] = $0 }
    backgroundColor.flatMap { codeAttributes[NSAttributedString.Key.backgroundColor] = $0 }
    font.flatMap {
      let quoteFontSize: CGFloat = $0.pointSize + fontIncrease
      codeAttributes[NSAttributedString.Key.font] = $0.withSize(quoteFontSize)
    }
    
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.headIndent = 20
    paragraphStyle.tabStops = [NSTextTab(textAlignment: .left, location: paragraphStyle.headIndent, options: [:])]
    codeAttributes[.paragraphStyle] = paragraphStyle
    
    return codeAttributes
  }
  
  public func formatText(_ attributedString: NSMutableAttributedString, range: NSRange, level: Int) {
    attributedString.deleteCharacters(in: range)
    let tab = NSAttributedString(string: "\t", attributes: attributedString.attributes(at: 0, effectiveRange: nil))
    let newLine = NSAttributedString(string: "\n", attributes: attributedString.attributes(at: 0, effectiveRange: nil))
    attributedString.insert(tab, at: 0)
    attributedString.append(newLine)
  }
}
