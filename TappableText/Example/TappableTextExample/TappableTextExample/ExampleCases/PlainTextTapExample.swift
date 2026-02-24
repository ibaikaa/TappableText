//
//  PlainTextTapExample.swift
//  TappableTextExample
//
//  Created by Ian on 24/2/26.
//

import SwiftUI
import TappableText

struct PlainTextTapExample: View {

    static let usageCode = """
TappableText("Try tapping anywhere in this sentence. Only learn and SwiftUI are keywords.") {
    TappableText.Keyword("learn") { }
        .color(.blue)
        .underlined(true, pattern: .solid)

    TappableText.Keyword("SwiftUI") { }
        .color(.orange)
        .underlined(true, color: .orange, pattern: .dash)
}
.textFont(.system(size: 16))
.onPlainWordsTap {
    // fired for any non-keyword word
}
"""

    static let usageDescription = ".onPlainWordsTap fires whenever the user taps a word that is not matched by any keyword. Useful for analytics, dismissing a view, or any ambient interaction."

    var body: some View {
        ExampleContainer(
            title: "Plain Text Tap",
            description: "Use .onPlainWordsTap to react when the user taps on any non-keyword part of the text.",
            usageCode: Self.usageCode,
            usageDescription: Self.usageDescription
        ) { showToast in
            VStack(alignment: .leading, spacing: 16) {
                Text("👇 Tap on regular words (not keywords)")
                    .font(.caption)
                    .foregroundStyle(.secondary)

                TappableText("Try tapping anywhere in this sentence. Only learn and SwiftUI are keywords.") {
                    TappableText.Keyword("learn") {
                        showToast("Keyword: learn")
                    }
                    .color(.blue)
                    .underlined(true, pattern: .solid)

                    TappableText.Keyword("SwiftUI") {
                        showToast("Keyword: SwiftUI")
                    }
                    .color(.orange)
                    .underlined(true, color: .orange, pattern: .dash)
                }
                .textFont(.system(size: 16))
                .onPlainWordsTap {
                    showToast("Plain word tapped!")
                }
            }
        }
    }
}
