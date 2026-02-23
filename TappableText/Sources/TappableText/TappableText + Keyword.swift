#if canImport(UIKit)
import UIKit
#endif

public extension TappableText {
    /// A model representing an interactive word or phrase.
    struct Keyword {
        let word: String
        let action: () -> Void
        var customColor: UIColor?
        var customFont: UIFont?
        var customUnderline: Bool?

        public init(_ word: String, action: @escaping () -> Void) {
            self.word = word
            self.action = action
        }
        
        public func color(_ color: UIColor) -> Keyword {
            var copy = self
            copy.customColor = color
            return copy
        }
        
        public func font(_ font: UIFont) -> Keyword {
            var copy = self
            copy.customFont = font
            return copy
        }
        
        public func underlined(_ isOn: Bool) -> Keyword {
            var copy = self
            copy.customUnderline = isOn
            return copy
        }
    }
}
