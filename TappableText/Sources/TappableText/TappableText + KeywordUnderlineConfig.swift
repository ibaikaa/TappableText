import SwiftUI

extension TappableText {
    /// A configuration for keyword underlining.
    struct KeywordUnderlineConfig {
        let isOn: Bool
        let color: Color?
        let pattern: Text.LineStyle.Pattern
        
        static var none: KeywordUnderlineConfig {
            .init(isOn: false, color: nil, pattern: .solid)
        }
    }
}
