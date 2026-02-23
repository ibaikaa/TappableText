import SwiftUI

extension TappableText {
    
    /// A container for attributed string fragments that handles URL-based tap dispatching.
    struct AttributedText: View {
        private var attributedString: AttributedString
        private var onTap: (() -> Void)?
        
        /// Stores handlers centrally to survive view re-renders.
        static var tapRegistry: [String: () -> Void] = [:]
        static var nextId: Int = 0
        
        init(_ string: String = "", modifier: ((inout AttributedString) -> Void)? = nil) {
            var attr = AttributedString(string)
            modifier?(&attr)
            self.attributedString = attr
        }
        
        var body: some View {
            Text(attributedString)
                .environment(\.openURL, OpenURLAction { url in
                    if url.scheme == "tappable", let id = url.host {
                        Self.tapRegistry[id]?()
                        return .handled
                    }
                    return .systemAction
                })
        }
        
        func onTap(_ action: @escaping () -> Void) -> Self {
            var copy = self
            copy.onTap = action
            return copy
        }
        
        static func + (lhs: Self, rhs: Self) -> Self {
            var result = lhs
            var rhsString = rhs.attributedString
            
            if let action = rhs.onTap {
                let id = "id_\(Self.nextId)"
                Self.nextId += 1
                Self.tapRegistry[id] = action
                rhsString.link = URL(string: "tappable://\(id)")
            }
            
            result.attributedString.append(rhsString)
            return result
        }
    }
}
