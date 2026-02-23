import SwiftUI

final class TapHandlerRegistry: ObservableObject {
    private var handlers: [String: () -> Void] = [:]
    
    func register(_ handler: @escaping () -> Void) -> String {
        let id = UUID().uuidString
        handlers[id] = handler
        return id
    }
    
    func handle(_ id: String) {
        handlers[id]?()
    }

    func unregisterAll() {
        handlers.removeAll()
    }
}
