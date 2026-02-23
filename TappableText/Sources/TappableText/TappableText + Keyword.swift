#if canImport(UIKit)
import UIKit
#endif

public extension TappableText {
    struct Keyword {
        let word: String
        let action: () -> Void
        
        var customColor: UIColor? = nil
        var customFont: UIFont? = nil
        var customUnderline: Bool? = nil

        public init(_ word: String, action: @escaping () -> Void) {
            self.word = word
            self.action = action
        }
        
        // Методы для цепочки вызовов внутри билдера
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

public extension TappableText {
    
    /// Билдер для удобного описания нескольких `Keyword` подряд.
    @resultBuilder
    struct KeywordBuilder {
        
        /// Собирает переданные `Keyword` в массив.
        ///
        /// - Parameter components: Переменное число аргументов типа `Keyword`.
        /// - Returns: Массив собранных ключевых слов.
        public static func buildBlock(_ components: TappableText.Keyword...) -> [TappableText.Keyword] {
            components
        }
    }
}
