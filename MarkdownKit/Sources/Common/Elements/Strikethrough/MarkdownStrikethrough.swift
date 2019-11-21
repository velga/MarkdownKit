//
//  MarkdownStrikethrough.swift
//  MarkdownKit
//
//  Created by Vladyslava Kirichenko on 21.11.19.
//  Copyright © 2019 Ivan Bruel. All rights reserved.
//

import Foundation

open class MarkdownStrikethrough: MarkdownCommonElement {
    fileprivate static let regex = "(.?|^)(~~)(.+?)(\\2)"
    
    open var font: MarkdownFont?
    open var color: MarkdownColor?
    
    open var regex: String {
        return MarkdownStrikethrough.regex
    }
    
    open var attributes: [NSAttributedString.Key: AnyObject] {
        var attributes = [NSAttributedString.Key: AnyObject]()
        if let font = font {
            attributes[NSAttributedString.Key.font] = font
        }
        if let color = color {
            attributes[NSAttributedString.Key.foregroundColor] = color
        }
        attributes[.strikethroughStyle] = NSNumber(value: NSUnderlineStyle.single.rawValue)
        return attributes
    }
    
    public init(font: MarkdownFont? = nil, color: MarkdownColor? = nil) {
        self.font = font
        self.color = color
    }
}
