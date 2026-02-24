//
//  LongTextExample.swift
//  TappableTextExample
//
//  Created by Ian on 24/2/26.
//

import SwiftUI
import TappableText

struct LongTextExample: View {

    static let usageCode = """
TappableText("Lorem ipsum dolor sit amet, consectetur adipiscing elit...") {
    TappableText.Keyword("Lorem ipsum") { }
        .color(.blue)
        .font(.system(size: 15, weight: .semibold))

    TappableText.Keyword("consectetur adipiscing elit") { }
        .color(.green)
        .underlined(true, color: .green, pattern: .solid)

    TappableText.Keyword("dolore magna aliqua") { }
        .color(.purple)
        .font(.system(size: 15, weight: .bold))
        .underlined(true, color: .purple, pattern: .dash)

    TappableText.Keyword("nostrud exercitation") { }
        .color(.orange)
        .underlined(true, color: .orange, pattern: .dot)

    TappableText.Keyword("voluptate velit") { }
        .color(.red)
        .font(.system(size: 15, weight: .semibold).italic())
}
.textFont(.system(size: 15))
"""

    static let usageDescription = "TappableText tokenizes the full string once at init and matches multi-word keywords greedily. Punctuation and whitespace are preserved exactly."

    var body: some View {
        ExampleContainer(
            title: "Long Text",
            description: "TappableText handles multi-sentence paragraphs with multiple keyword matches correctly, preserving all punctuation and whitespace.",
            usageCode: Self.usageCode,
            usageDescription: Self.usageDescription
        ) { showToast in
            TappableText(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
            ) {
                TappableText.Keyword("Lorem ipsum") {
                    showToast("Lorem ipsum")
                }
                .color(.blue)
                .font(.system(size: 15, weight: .semibold))

                TappableText.Keyword("consectetur adipiscing elit") {
                    showToast("consectetur")
                }
                .color(.green)
                .underlined(true, color: .green, pattern: .solid)

                TappableText.Keyword("dolore magna aliqua") {
                    showToast("dolore magna")
                }
                .color(.purple)
                .font(.system(size: 15, weight: .bold))
                .underlined(true, color: .purple, pattern: .dash)

                TappableText.Keyword("nostrud exercitation") {
                    showToast("nostrud")
                }
                .color(.orange)
                .underlined(true, color: .orange, pattern: .dot)

                TappableText.Keyword("voluptate velit") {
                    showToast("voluptate")
                }
                .color(.red)
                .font(.system(size: 15, weight: .semibold).italic())
            }
            .textFont(.system(size: 15))
        }
    }
}
