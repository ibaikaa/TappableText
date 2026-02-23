import SwiftUI

public extension TappableText {
    /// A model representing an interactive word or phrase.
    struct Keyword {
        let word: String
        let action: () -> Void
        var customColor: Color?
        var customFont: Font?
        var customUnderline: KeywordUnderlineConfig?

        public init(_ word: String, action: @escaping () -> Void) {
            self.word = word
            self.action = action
        }
        
        public func color(_ color: Color) -> Keyword {
            var copy = self
            copy.customColor = color
            return copy
        }
        
        public func font(_ font: Font) -> Keyword {
            var copy = self
            copy.customFont = font
            return copy
        }
        
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
