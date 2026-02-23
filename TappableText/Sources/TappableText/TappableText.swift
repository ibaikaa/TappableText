import SwiftUI

/// A highly customizable SwiftUI view for rendering interactive text with highlighted keywords.
///
/// `TappableText` parses a raw string and matches specific phrases (keywords) to apply unique styles
/// and tap actions. It preserves punctuation and whitespace while providing a DSL-based approach
/// to defining interactivity.
///
/// ### Overview
/// Unlike a standard `Text` view with `AttributedString` links, `TappableText` offers:
/// - **Granular Control**: Specific fonts, colors, and underline patterns per keyword.
/// - **Global Styling**: Set default themes for all keywords at once.
/// - **Memory Safety**: Automated cleanup of tap handlers to prevent leaks.
/// - **Accessibility**: Automatic grouping of fragments for a seamless VoiceOver experience.
///
/// ### Usage
///
/// ```swift
/// TappableText("Please accept our Terms and Privacy Policy.") {
///     TappableText.Keyword("Terms") {
///         print("Terms tapped")
///     }
///     .color(.orange)
///     .underlined(true, pattern: .dash)
///
///     TappableText.Keyword("Privacy Policy") {
///         print("Policy tapped")
///     }
///     .underlined(true, color: .green)
/// }
/// .keywordColor(.blue)
/// .textFont(.system(size: 16))
/// .onPlainWordsTap {
///     print("Tapped on non-keyword text")
/// }
/// ```
///
/// > Important: `TappableText` uses an internal registry to manage closures.
/// It automatically cleans up resources when the view disappears via `.onDisappear`.
///
/// > Note: Performance is optimized by tokenizing the sentence once during initialization.
@MainActor
public struct TappableText: View {
    
    /// Coordinates tap events and closure storage.
    @StateObject private var registry = TapHandlerRegistry()
    
    private let text: String
    private let keywords: [Keyword]
    
    private var textColor: Color = .primary
    private var keywordColor: Color = .blue
    private var font: Font = .body
    private var underlineConfig: KeywordUnderlineConfig = .none
    private var onPlainWordsTap: (() -> Void)?
    
    private let computedWords: [String]
    
    /// Creates a new interactive text view.
    ///
    /// - Parameters:
    ///   - text: The full source string to be parsed.
    ///   - keywords: A `@KeywordBuilder` closure returning an array of interactive phrases.
    public init(
        _ text: String,
        @KeywordBuilder keywords: () -> [Keyword]
    ) {
        self.text = text
        self.keywords = keywords()
        
        // Memoized tokenization: performed only once during init to save CPU cycles in body.
        self.computedWords = TokenizeService.tokenizeSentence(text)
    }
    
    public var body: some View {
        renderText()
            .onDisappear {
                registry.unregisterAll()
            }
    }
    
    /// Internal rendering engine that builds the final interactive view.
    func renderText() -> some View {
        let words = computedWords
        var combined = AttributedText(registry: registry) { $0.font = font }
        var i = 0
        
        while i < words.count {
            var matchedKeyword: Keyword?
            var keywordLength = 0
            
            // Greedily search for the longest matching keyword at current position
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
    
    /// Overrides the color for all non-keyword text.
    public func textColor(_ color: Color) -> Self {
        var copy = self
        copy.textColor = color
        return copy
    }
    
    /// Sets a default color for all keywords. Individual keyword colors will override this.
    public func keywordColor(_ color: Color) -> Self {
        var copy = self
        copy.keywordColor = color
        return copy
    }
    
    /// Sets the font for the entire text view. Individual keyword fonts will override this.
    public func textFont(_ font: Font) -> Self {
        var copy = self
        copy.font = font
        return copy
    }
    
    /// Configures the default underline style for all keywords.
    ///
    /// - Parameters:
    ///   - isOn: Whether underlining is enabled.
    ///   - color: The color of the underline. If nil, inherits the keyword's foreground color.
    ///   - pattern: The pattern of the line (e.g., solid, dash, dot).
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
    
    /// Provides an action to be executed when the user taps on any non-interactive part of the text.
    public func onPlainWordsTap(_ perform: @escaping () -> Void) -> Self {
        var copy = self
        copy.onPlainWordsTap = perform
        return copy
    }
}
