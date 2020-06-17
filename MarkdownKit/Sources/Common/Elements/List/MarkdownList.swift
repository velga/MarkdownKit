//
//  MarkdownList.swift
//  Pods
//
//  Created by Ivan Bruel on 18/07/16.
//
//
import Foundation

open class MarkdownList: MarkdownLevelElement {

  fileprivate static let regex = "^([\\*\\+\\-]{1,%@})\\s+(.+)$"

  open var maxLevel: Int
  open var font: MarkdownFont?
  open var color: MarkdownColor?
  open var indicator: String

  open var regex: String {
    let level: String = maxLevel > 0 ? "\(maxLevel)" : ""
    return String(format: MarkdownList.regex, level)
  }

  public init(font: MarkdownFont? = nil, maxLevel: Int = 0, indicator: String = "•",
              color: MarkdownColor? = nil) {
    self.maxLevel = maxLevel
    self.indicator = indicator
    self.font = font
    self.color = color
  }

  open func formatText(_ attributedString: NSMutableAttributedString, range: NSRange, level: Int) {
    let levelIndicatorList = [1: "\(indicator) ", 2: "\(indicator) ", 3: "◦ ", 4: "◦ ", 5: "▪︎ ", 6: "▪︎ "]
    guard let indicatorIcon = levelIndicatorList[level] else { return }
    attributedString.replaceCharacters(in: range, with: indicatorIcon)
    attributedString.addAttributes([.paragraphStyle : defaultParagraphStyle(level: level)], range: range)
  }

  private func defaultParagraphStyle(level: Int) -> NSMutableParagraphStyle {
    let indent = 4 + CGFloat(level * 4)
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.firstLineHeadIndent = indent
    paragraphStyle.headIndent = indent + 10
    paragraphStyle.paragraphSpacing = 4
    return paragraphStyle
  }
}
