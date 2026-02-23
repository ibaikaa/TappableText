import UIKit
import SwiftUI

@MainActor
public struct TappableText: View {
    
    /// Весь текст для отображения.
    private let text: String
    
    /// Цвет обычных слов.
    private var textColor: UIColor?
    
    /// Цвет кликабельных ключевых слов.
    private var keywordsColor: UIColor?
    
    /// Шрифт текста
    private var font: UIFont
    
    /// Конфиг подчеркивания текста снизу
    private var underlineConfig: KeywordUnderlineConfig
    
    /// Действие при нажатии на обычные слова.
    private var onPlainWordsTap: (() -> Void)?
    
    /// Массив ключевых слов и их действий.
    private let keywords: [Keyword]
    
    /// Инициализатор компонента.
    ///
    /// - Parameters:
    ///   - text: Исходный текст, из которого будут выделяться ключевые слова.
    ///   - keywords: @KeywordBuilder, возвращающий список `Keyword`
    ///     — пар (слово, действие).
    public init(
        _ text: String,
        @KeywordBuilder keywords: () -> [Keyword]
    ) {
        self.text = text
        self.keywords = keywords()

        self.textColor = nil
        self.keywordsColor = nil
        self.font = .systemFont(ofSize: 16)
        self.underlineConfig = .none
        self.onPlainWordsTap = nil
    }
    
    // Улучшенный токенизатор: разделяет слова, пробелы и пунктуацию
    private var textWords: [String] {
        let pattern = #"(\s+|\w+|[^\w\s])"#
        let regex = try? NSRegularExpression(pattern: pattern)
        let range = NSRange(text.startIndex..., in: text)
        let matches = regex?.matches(in: text, range: range) ?? []
        return matches.map { String(text[Range($0.range, in: text)!]) }
    }
    
    public var body: some View {
        let words = textWords
        var view = AttributedText("") { $0.font = font }
        var i = 0
        
        while i < words.count {
            var matchedKeyword: Keyword?
            var keywordLength = 0
            
            for keyword in keywords {
                // Разбиваем ключевую фразу на такие же токены, как и основной текст
                let keywordTokens = tokenize(keyword.word)
                if i + keywordTokens.count <= words.count {
                    let slice = Array(words[i..<(i + keywordTokens.count)])
                    
                    // Сравниваем без учета регистра и лишних пробелов по краям
                    let normalizedSlice = slice.map { $0.lowercased().trimmingCharacters(in: .whitespaces) }
                    let normalizedKeyword = keywordTokens.map { $0.lowercased().trimmingCharacters(in: .whitespaces) }
                    
                    if normalizedSlice == normalizedKeyword {
                        matchedKeyword = keyword
                        keywordLength = keywordTokens.count
                        break
                    }
                }
            }
            
            if let matched = matchedKeyword {
                let phrase = words[i..<(i + keywordLength)].joined()
                view = view + AttributedText(phrase) { label in
                    label.foregroundColor = matched.customColor
                    ?? keywordsColor
                    ?? .label
                    
                    label.font = matched.customFont ?? font
                    
                    let isUnderlined = matched.customUnderline ?? underlineConfig.isOn
                    label.underlineStyle = isUnderlined ? .single : .none
                    label.underlineColor = matched.customColor ?? underlineConfig.color
                }.onTap {
                    matched.action()
                }
                i += keywordLength
            } else {
                let word = words[i]
                view = view + AttributedText(word) { label in
                    label.foregroundColor = textColor ?? .label
                    label.font = font
                }.onTap {
                    onPlainWordsTap?()
                }
                i += 1
            }
        }
        return view
    }
    
    // Вспомогательная функция для токенизации ключевых слов
    private func tokenize(_ input: String) -> [String] {
        let pattern = #"(\s+|\w+|[^\w\s])"#
        let regex = try? NSRegularExpression(pattern: pattern)
        let range = NSRange(input.startIndex..., in: input)
        let matches = regex?.matches(in: input, range: range) ?? []
        return matches.map { String(input[Range($0.range, in: input)!]) }
    }
    
    /// Метод для настройки цвета обычных слов.
    public func textColor(_ color: UIColor) -> Self {
        var copy = self
        copy.textColor = color
        return copy
    }
    
    /// Метод для настройки цвета кликабельных ключевых слов.
    public func keywordsColor(_ color: UIColor) -> Self {
        var copy = self
        copy.keywordsColor = color
        return copy
    }
    
    /// Метод для настройки шрифта текста
    public func textFont(_ font: UIFont) -> Self {
        var copy = self
        copy.font = font
        return copy
    }
    
    /// Метод для настройки подчеркивания ключевых слов
    public func underlineKeywords(_ isOn: Bool) -> Self {
        var copy = self
        copy.underlineConfig = .init(isOn: isOn, color: textColor ?? .label)
        return copy
    }
    
    /// Метод для настройки действия при нажатии на обычные, не ключевые слова
    public func onPlainWordsTap(_ perform: @escaping () -> Void) -> Self {
        var copy = self
        copy.onPlainWordsTap = perform
        return copy
    }
}
