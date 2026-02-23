import UIKit

extension TappableText {
    @MainActor
    struct KeywordUnderlineConfig {
        let isOn: Bool
        let color: UIColor
        
        static var `none` = KeywordUnderlineConfig(isOn: false, color: .clear)
    }
}
