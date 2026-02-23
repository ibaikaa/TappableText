import UIKit

public extension TappableText {
    /// A configuration for keyword underlining.
    struct KeywordUnderlineConfig {
        let isOn: Bool
        let color: UIColor
        static var none: KeywordUnderlineConfig { .init(isOn: false, color: .clear) }
    }
}
