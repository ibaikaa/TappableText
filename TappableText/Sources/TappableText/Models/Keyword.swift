import SwiftUI

public extension TappableText {
    /// A configuration model representing a specific phrase to be made interactive.
    struct Keyword {
        let word: String
        let action: () -> Void
        var customColor: Color?
        var customFont: Font?
        var customUnderline: KeywordUnderlineConfig?
        
        /// Creates a keyword to match within the parent text.
        /// - Parameters:
        ///   - word: The exact phrase to match (case-insensitive).
        ///   - action: The closure to execute when the phrase is tapped.
        public init(_ word: String, action: @escaping () -> Void) {
            self.word = word
            self.action = action
        }
        
        /// Sets a specific color for this keyword, overriding the global `keywordColor`.
        public func color(_ color: Color) -> Keyword {
            var copy = self
            copy.customColor = color
            return copy
        }
        
        /// Sets a specific font for this keyword, overriding the global `textFont`.
        public func font(_ font: Font) -> Keyword {
            var copy = self
            copy.customFont = font
            return copy
        }
        
        /// Configures a custom underline for this specific keyword.
        public func underlined(
            _ isOn: Bool,
            color: Color? = nil,
            pattern: Text.LineStyle.Pattern = .solid
        ) -> Keyword {
            var copy = self
            copy.customUnderline = KeywordUnderlineConfig(
                isOn: isOn,
                color: color,
                pattern: pattern
            )
            return copy
        }
    }
}

public extension TappableText {
    @resultBuilder
    struct KeywordBuilder {
        public static func buildExpression(_ expression: Keyword) -> [Keyword] {
            [expression]
        }

        public static func buildExpression(_ expression: [Keyword]) -> [Keyword] {
            expression
        }
        
        public static func buildArray(_ components: [[Keyword]]) -> [Keyword] {
            components.flatMap { $0 }
        }

        public static func buildExpression(_ expression: [Keyword]...) -> [Keyword] {
            expression.flatMap { $0 }
        }

        public static func buildBlock(_ components: [Keyword]...) -> [Keyword] {
            components.flatMap { $0 }
        }

        public static func buildOptional(_ component: [Keyword]?) -> [Keyword] {
            component ?? []
        }

        public static func buildEither(first component: [Keyword]) -> [Keyword] {
            component
        }

        public static func buildEither(second component: [Keyword]) -> [Keyword] {
            component
        }
    }
}
