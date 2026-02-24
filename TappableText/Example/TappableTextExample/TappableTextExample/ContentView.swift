import SwiftUI
import TappableText

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List {
                Section {
                    NavigationLink("1. Basic Keywords") {
                        BasicKeywordsExample()
                    }
                    
                    NavigationLink("2. Per-Keyword Styling") {
                        PerKeywordStylingExample()
                    }
                    
                    NavigationLink("3. Global vs Override") {
                        GlobalVsOverrideExample()
                    }
                    
                    NavigationLink("4. Font Variants") {
                        FontVariantsExample()
                    }
                    
                    NavigationLink("5. Underline Styles") {
                        UnderlineStylesExample()
                    }
                    
                    NavigationLink("6. Plain Text Tap") {
                        PlainTextTapExample()
                    }
                    
                    NavigationLink("7. Multi-Language / Long Text") {
                        LongTextExample()
                    }
                    
                    NavigationLink("8. Real-World: Legal Agreement") {
                        LegalAgreementExample()
                    }
                    
                    NavigationLink("9. Real-World: Chat Mention") {
                        ChatMentionExample()
                    }
                    
                    NavigationLink("10. Kitchen Sink") {
                        KitchenSinkExample()
                    }
                } header: {
                    Text("TappableText Showcase")
                        .font(.headline)
                }
            }
            .navigationTitle("TappableText")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    ContentView()
}
