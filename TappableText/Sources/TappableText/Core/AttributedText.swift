import SwiftUI

/// A container for attributed string fragments that handles URL-based tap dispatching.
struct AttributedText: View {
    let registry: TapHandlerRegistry
    private var attributedString: AttributedString
    private var onTap: (() -> Void)?
    
    init(
        _ string: String = "",
        registry: TapHandlerRegistry,
        modifier: ((inout AttributedString) -> Void)? = nil
    ) {
        var attr = AttributedString(string)
        modifier?(&attr)
        self.registry = registry
        self.attributedString = attr
    }
    
    var body: some View {
        Text(attributedString)
            .environment(\.openURL, OpenURLAction { url in
                if url.scheme == "tappable", let id = url.host {
                    registry.handle(id)
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
            let id = lhs.registry.register(action)
            rhsString.link = URL(string: "tappable://\(id)")
        }
        
        result.attributedString.append(rhsString)
        return result
    }
}
