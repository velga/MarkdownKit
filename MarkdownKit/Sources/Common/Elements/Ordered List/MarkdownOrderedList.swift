//
//  MarkdownOrderedList.swift
//  MarkdownKit
//
//  Created by Bruno Guidolim on 17.06.20.
//  Copyright © 2020 Ivan Bruel. All rights reserved.
//

import Foundation

open class MarkdownOrderedList: MarkdownLevelElement {

  fileprivate static let regex = "^([0-9].)\\s+(.+)$"

  open var maxLevel: Int
  open var font: MarkdownFont?
  open var color: MarkdownColor?

  private var currentNumber: Int = 1
  private var lastRange: NSRange?
  private var lastString: String?

  open var regex: String {
    let level: String = maxLevel > 0 ? "\(maxLevel)" : ""
    return String(format: MarkdownOrderedList.regex, level)
  }

  public init(font: MarkdownFont? = nil, maxLevel: Int = 0, color: MarkdownColor? = nil) {
    self.maxLevel = maxLevel
    self.font = font
    self.color = color
  }

  open func formatText(_ attributedString: NSMutableAttributedString, range: NSRange, level: Int) {
    if lastString != attributedString.string {
        currentNumber = 1
        lastRange = nil
    }

    if let previousRange = lastRange {
        let inBetweenString = (attributedString.string as NSString).substring(with: previousRange.union(range))
        if inBetweenString.components(separatedBy: .newlines).count > 2 {
            currentNumber = 1
        }
    }

    attributedString.replaceCharacters(in: range, with: "\(currentNumber). ")
    attributedString.addAttributes([.paragraphStyle: defaultParagraphStyle(level: level)],
                                   range: range)
    currentNumber += 1
    lastRange = range
    lastString = attributedString.string
  }

  private func defaultParagraphStyle(level: Int) -> NSMutableParagraphStyle {
    let indent = 2 + CGFloat(level * 4)
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.firstLineHeadIndent = indent
    paragraphStyle.headIndent = indent + 10
    paragraphStyle.paragraphSpacing = 4
    return paragraphStyle
  }
}
