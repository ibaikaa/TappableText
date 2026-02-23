import SwiftUI

/// A SwiftUI view that renders interactive text with customizable keyword highlighting.
///
/// `TappableText` identifies specific phrases within a string and applies unique styling
/// and tap actions to them, while keeping punctuation and formatting intact.
@MainActor
public struct TappableText: View {
    
    @StateObject private var registry = TapHandlerRegistry()
    
    private let text: String
    private let keywords: [Keyword]
    
    private var textColor: Color = .primary
    private var keywordColor: Color = .blue
    private var font: Font = .body
    private var underlineConfig: KeywordUnderlineConfig = .none
    private var onPlainWordsTap: (() -> Void)?
    
    private let computedWords: [String]
    
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
        
        self.computedWords = TokenizeService.tokenizeSentence(text)
    }
    
    // MARK: - Internal Logic
    
    public var body: some View {
        renderText()
            .onDisappear {
                registry.unregisterAll()
            }
    }
    
    func renderText() -> some View {
        let words = computedWords
        var combined = AttributedText(registry: registry) { $0.font = font }
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
                combined = combined + AttributedText(phrase, registry: registry) { label in
                    label.foregroundColor = matched.customColor ?? keywordColor
                    label.font = matched.customFont ?? font
                    
                    let isUnderlined = matched.customUnderline?.isOn ?? underlineConfig.isOn
                    if isUnderlined {
                        let underlineColor = matched.customUnderline?.color ??
                        matched.customColor ??
                        underlineConfig.color ??
                        keywordColor
                        
                        label.underlineStyle = .init(
                            pattern: matched.customUnderline?.pattern ?? underlineConfig.pattern,
                            color: underlineColor
                        )
                    }
                }.onTap {
                    matched.action()
                }
                i += keywordLength
            } else {
                let word = words[i]
                combined = combined + AttributedText(word, registry: registry) { label in
                    label.foregroundColor = textColor
                    label.font = font
                }.onTap {
                    onPlainWordsTap?()
                }
                i += 1
            }
        }
        
        return combined
            .fixedSize(horizontal: false, vertical: true)
            .accessibilityElement(children: .combine)
            .accessibilityLabel(text)
    }
    
    private func tokenize(_ input: String) -> [String] {
        TokenizeService.tokenizeWord(input)
    }
    
    // MARK: - Modifiers
    
    /// Sets the color for non-keyword text.
    public func textColor(_ color: Color) -> Self {
        var copy = self
        copy.textColor = color
        return copy
    }
    
    /// Sets the default color for all keywords.
    public func keywordColor(_ color: Color) -> Self {
        var copy = self
        copy.keywordColor = color
        return copy
    }
    
    /// Sets the font for the entire text.
    public func textFont(_ font: Font) -> Self {
        var copy = self
        copy.font = font
        return copy
    }
    
    /// Enables or disables underlining for keywords.
    public func keywordUnderline(
        _ isOn: Bool,
        color: Color? = nil,
        pattern: Text.LineStyle.Pattern = .solid
    ) -> Self {
        var copy = self
        copy.underlineConfig = KeywordUnderlineConfig(
            isOn: isOn,
            color: color ?? keywordColor,
            pattern: pattern
        )
        return copy
    }
    
    /// Sets a global action for taps on non-keyword parts of the text.
    public func onPlainWordsTap(_ perform: @escaping () -> Void) -> Self {
        var copy = self
        copy.onPlainWordsTap = perform
        return copy
    }
}
