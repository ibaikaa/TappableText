import Foundation

public extension TappableText {
    @resultBuilder
    struct KeywordBuilder {
        public static func buildBlock(_ components: Keyword...) -> [Keyword] {
            components
        }
    }
}
