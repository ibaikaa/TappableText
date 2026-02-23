//
//  File.swift
//  TappableText
//
//  Created by Ian on 23/2/26.
//

import Foundation

public extension TappableText {
    @resultBuilder
    struct KeywordBuilder {
        public static func buildBlock(_ components: Keyword...) -> [Keyword] {
            components
        }
    }
}
