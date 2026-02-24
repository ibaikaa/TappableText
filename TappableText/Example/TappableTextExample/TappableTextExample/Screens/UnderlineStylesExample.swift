//
//  UnderlineStylesExample.swift
//  TappableTextExample
//
//  Created by Ian on 24/2/26.
//

import SwiftUI
import TappableText

/// Full showcase of all supported underline patterns.
struct UnderlineStylesExample: View {
    var body: some View {
        ExampleContainer(
            title: "Underline Styles",
            description: "Every keyword supports solid, dash, dot, and dashDot underline patterns with custom colors."
        ) { showToast in
            VStack(alignment: .leading, spacing: 20) {
                TappableText("Four patterns: solid line, dashed line, dotted line, and dash-dot line.") {
                    TappableText.Keyword("solid line") {
                        showToast("solid")
                    }
                    .color(.blue)
                    .underlined(true, color: .blue, pattern: .solid)
                    
                    TappableText.Keyword("dashed line") {
                        showToast("dash")
                    }
                    .color(.purple)
                    .underlined(true, color: .purple, pattern: .dash)
                    
                    TappableText.Keyword("dotted line") {
                        showToast("dot")
                    }
                    .color(.green)
                    .underlined(true, color: .green, pattern: .dot)
                    
                    TappableText.Keyword("dash-dot line") {
                        showToast("dashDot")
                    }
                    .color(.orange)
                    .underlined(true, color: .orange, pattern: .dashDot)
                }
                .textFont(.system(size: 16))
                
                Divider()
                
                // Underline color differs from text color
                TappableText("Here underline color is different from the keyword text color itself.") {
                    TappableText.Keyword("underline color is different") {
                        showToast("different underline")
                    }
                    .color(.indigo)
                    .underlined(true, color: .pink, pattern: .solid)
                }
                .textFont(.system(size: 16))
                
                Divider()
                
                codeHint("""
.underlined(true, color: .blue, pattern: .solid)
.underlined(true, color: .purple, pattern: .dash)
.underlined(true, color: .green, pattern: .dot)
.underlined(true, color: .orange, pattern: .dashDot)
""")
            }
        }
    }
}
