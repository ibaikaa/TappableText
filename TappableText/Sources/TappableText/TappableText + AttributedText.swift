import SwiftUI

extension TappableText {
    
    /// Вспомогательный View для построения частей текста с атрибутами и обработчиками tap.
    ///
    /// Собирает фрагменты `AttributedString`, умеет объединять их через `+` и
    /// регистрировать URL-ссылки вида `tappable://<id>` для передачи событий клика.
    struct AttributedText: View {
        
        private var attributedString: AttributedString
        private var onTap: (() -> Void)? = nil
        private var tapHandlers: [String: () -> Void] = [:]
        private var currentId: Int = 0
        
        /// Инициализирует фрагмент текста.
        ///
        /// - Parameters:
        ///   - stringKey: Отображаемая строка.
        ///   - modifier: Замыкание для модификации `AttributedString` (цвет, шрифт и т.п.).
        ///   - onTap: Опциональное действие при тапе на этот фрагмент.
        init(
            _ string: String = "",
            modifier: ((_ text: inout AttributedString) -> Void)? = nil,
            onTap: (() -> Void)? = nil
        ) {
            var attributed = AttributedString(stringLiteral: string)
            modifier?(&attributed)
            self.attributedString = attributed
            self.onTap = onTap
        }
        
        var body: some View {
            Text(attributedString)
                .environment(\.openURL, OpenURLAction { url in
                    if let id = url.host {
                        tapHandlers[id]?()
                    }
                    return .discarded
                })
        }
        
        /// Объединяет два `AttributedText` через конкатенацию.
        ///
        /// Если у правого фрагмента задано `onTap`, то ему присваивается уникальный `link`
        /// вида `tappable://<id>` для последующей обработки.
        static func + (lhs: Self, rhs: Self) -> Self {
            var result = lhs
            var rhsString = rhs.attributedString
            
            if let handler = rhs.onTap {
                let id = result.registerTapHandler(handler)
                rhsString.link = URL(string: "tappable://\(id)")
            }
            
            result.attributedString.append(rhsString)
            return result
        }
                
        /// Применяет дополнительное действие на существующий фрагмент.
        ///
        /// - Parameter action: Замыкание, выполняемое при тапе на этот фрагмент.
        /// - Returns: Новый `AttributedText` с зарегистрированным `onTap`.
        func onTap(_ action: @escaping () -> Void) -> Self {
            var copy = self
            copy.onTap = action
            return copy
        }
        
        /// Регистрирует обработчик тапов и возвращает уникальный ключ.
        private mutating func registerTapHandler(_ handler: @escaping () -> Void) -> String {
            let id = "tappable-\(currentId)"
            currentId += 1
            tapHandlers[id] = handler
            return id
        }
        
        /// Возвращает зарегистрированный обработчик по его ключу.
        private func getTapHandler(for id: String) -> (() -> Void)? {
            tapHandlers[id]
        }
    }
}
