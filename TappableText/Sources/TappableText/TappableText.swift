import SwiftUI

#if canImport(UIKit)
import UIKit
#endif

/// A SwiftUI view that renders interactive text with customizable keyword highlighting.
///
/// `TappableText` identifies specific phrases within a string and applies unique styling
/// and tap actions to them, while keeping punctuation and formatting intact.
@MainActor
public struct TappableText: View {
    
    private let text: String
    private var textColor: UIColor?
    private var keywordsColor: UIColor?
    private var font: UIFont
    private var underlineConfig: KeywordUnderlineConfig
    private var onPlainWordsTap: (() -> Void)?
    private let keywords: [Keyword]
    
    /// Initializes a new TappableText.
    /// - Parameters:
    ///   - text: The full string to display.
    ///   - keywords: A result builder that returns an array of `Keyword` objects.
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
    
    // MARK: - Internal Logic
    
    private var textWords: [String] {
        let pattern = #"(\s+|\w+|[^\w\s])"#
        let regex = try? NSRegularExpression(pattern: pattern)
        let range = NSRange(text.startIndex..., in: text)
        let matches = regex?.matches(in: text, range: range) ?? []
        return matches.map { String(text[Range($0.range, in: text)!]) }
    }
    
    private func tokenize(_ input: String) -> [String] {
        let pattern = #"(\s+|\w+|[^\w\s])"#
        let regex = try? NSRegularExpression(pattern: pattern)
        let range = NSRange(input.startIndex..., in: input)
        let matches = regex?.matches(in: input, range: range) ?? []
        return matches.map { String(input[Range($0.range, in: input)!]) }
    }
    
    public var body: some View {
        let words = textWords
        var combined = AttributedText("") { $0.font = font }
        var i = 0
        
        while i < words.count {
            var matchedKeyword: Keyword?
            var keywordLength = 0
            
            for keyword in keywords {
                let keywordTokens = tokenize(keyword.word)
                if i + keywordTokens.count <= words.count {
                    let slice = Array(words[i..<(i + keywordTokens.count)])
                    
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
                combined = combined + AttributedText(phrase) { label in
                    label.foregroundColor = matched.customColor ?? keywordsColor ?? .label
                    label.font = matched.customFont ?? font
                    
                    let isUnderlined = matched.customUnderline ?? underlineConfig.isOn
                    label.underlineStyle = isUnderlined ? .single : .none
                    label.underlineColor = matched.customColor ?? keywordsColor ?? underlineConfig.color
                }.onTap {
                    matched.action()
                }
                i += keywordLength
            } else {
                let word = words[i]
                combined = combined + AttributedText(word) { label in
                    label.foregroundColor = textColor ?? .label
                    label.font = font
                }.onTap {
                    onPlainWordsTap?()
                }
                i += 1
            }
        }
        
        return combined
            .fixedSize(horizontal: false, vertical: true)
    }
    
    // MARK: - Modifiers
    
    /// Sets the color for non-keyword text.
    public func textColor(_ color: UIColor) -> Self {
        var copy = self
        copy.textColor = color
        return copy
    }
    
    /// Sets the default color for all keywords.
    public func keywordsColor(_ color: UIColor) -> Self {
        var copy = self
        copy.keywordsColor = color
        return copy
    }
    
    /// Sets the font for the entire text.
    public func textFont(_ font: UIFont) -> Self {
        var copy = self
        copy.font = font
        return copy
    }
    
    /// Enables or disables underlining for keywords.
    public func underlineKeywords(_ isOn: Bool) -> Self {
        var copy = self
        copy.underlineConfig = .init(isOn: isOn, color: keywordsColor ?? textColor ?? .label)
        return copy
    }
    
    /// Sets a global action for taps on non-keyword parts of the text.
    public func onPlainWordsTap(_ perform: @escaping () -> Void) -> Self {
        var copy = self
        copy.onPlainWordsTap = perform
        return copy
    }
}
