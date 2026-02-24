//
//  PerKeywordStylingExample.swift
//  TappableTextExample
//
//  Created by Ian on 24/2/26.
//

import SwiftUI
import TappableText

/// Each keyword has its own color, font, and underline — fully independent.
struct PerKeywordStylingExample: View {
    var body: some View {
        ExampleContainer(
            title: "Per-Keyword Styling",
            description: "Every keyword can have its own color, font weight, and underline style — fully independent from each other."
        ) { showToast in
            VStack(alignment: .leading, spacing: 16) {
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
                
                Divider()
                
                codeHint("""
TappableText.Keyword("Swift") { ... }
    .color(.orange)
    .font(.system(size: 17, weight: .bold))
    .underlined(true, color: .orange, pattern: .solid)
""")
            }
        }
    }
}
