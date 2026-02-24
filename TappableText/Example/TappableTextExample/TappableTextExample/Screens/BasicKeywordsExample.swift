//
//  BasicKeywordsExample.swift
//  TappableTextExample
//
//  Created by Ian on 24/2/26.
//

import SwiftUI
import TappableText

/// Simplest usage: just pass keywords with actions, no extra styling needed.
struct BasicKeywordsExample: View {
    var body: some View {
        ExampleContainer(
            title: "Basic Keywords",
            description: "The minimal setup. Keywords get the default blue color automatically."
        ) { showToast in
            VStack(alignment: .leading, spacing: 16) {
                TappableText("Please read our Terms of Service and Privacy Policy before continuing.") {
                    TappableText.Keyword("Terms of Service") {
                        showToast("Terms of Service")
                    }
                    TappableText.Keyword("Privacy Policy") {
                        showToast("Privacy Policy")
                    }
                }
                .textFont(.system(size: 16))

                Divider()

                // Source hint
                codeHint("""
TappableText("...Terms of Service...Privacy Policy...") {
    TappableText.Keyword("Terms of Service") { ... }
    TappableText.Keyword("Privacy Policy") { ... }
}
""")
            }
        }
    }
}
