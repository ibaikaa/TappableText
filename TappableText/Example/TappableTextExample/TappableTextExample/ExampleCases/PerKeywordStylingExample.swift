//
//  PerKeywordStylingExample.swift
//  TappableTextExample
//
//  Created by Ian on 24/2/26.
//

import SwiftUI
import TappableText

struct PerKeywordStylingExample: View {

    static let usageCode = """
TappableText("Swift is fast, Kotlin is expressive, and Rust is safe.") {
    TappableText.Keyword("Swift") { }
        .color(.orange)
        .font(.system(size: 17, weight: .bold))
        .underlined(true, color: .orange, pattern: .solid)

    TappableText.Keyword("Kotlin") { }
        .color(.purple)
        .font(.system(size: 17, weight: .semibold).italic())
        .underlined(true, color: .purple, pattern: .dash)

    TappableText.Keyword("Rust") { }
        .color(.red)
        .font(.system(size: 17, weight: .heavy))
        .underlined(true, color: .red, pattern: .dot)
}
.textFont(.system(size: 17))
"""

    static let usageDescription = "Each keyword is fully independent. Use .color(), .font(), and .underlined() per keyword to override any default. Chaining order doesn't matter."

    var body: some View {
        ExampleContainer(
            title: "Per-Keyword Styling",
            description: "Every keyword can have its own color, font weight, and underline style — fully independent from each other.",
            usageCode: Self.usageCode,
            usageDescription: Self.usageDescription
        ) { showToast in
            TappableText("Swift is fast, Kotlin is expressive, and Rust is safe.") {
                TappableText.Keyword("Swift") {
                    showToast("Swift 🦅")
                }
                .color(.orange)
                .font(.system(size: 17, weight: .bold))
                .underlined(true, color: .orange, pattern: .solid)

                TappableText.Keyword("Kotlin") {
                    showToast("Kotlin 🟣")
                }
                .color(.purple)
                .font(.system(size: 17, weight: .semibold).italic())
                .underlined(true, color: .purple, pattern: .dash)

                TappableText.Keyword("Rust") {
                    showToast("Rust 🦀")
                }
                .color(.red)
                .font(.system(size: 17, weight: .heavy))
                .underlined(true, color: .red, pattern: .dot)
            }
            .textFont(.system(size: 17))
        }
    }
}
