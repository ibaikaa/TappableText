//
//  UnderlineStylesExample.swift
//  TappableTextExample
//
//  Created by Ian on 24/2/26.
//

import SwiftUI
import TappableText

struct UnderlineStylesExample: View {

    static let usageCode = """
TappableText("Four patterns: solid line, dashed line, dotted line, and dash-dot line.") {
    TappableText.Keyword("solid line") { }
        .color(.blue)
        .underlined(true, color: .blue, pattern: .solid)

    TappableText.Keyword("dashed line") { }
        .color(.purple)
        .underlined(true, color: .purple, pattern: .dash)

    TappableText.Keyword("dotted line") { }
        .color(.green)
        .underlined(true, color: .green, pattern: .dot)

    TappableText.Keyword("dash-dot line") { }
        .color(.orange)
        .underlined(true, color: .orange, pattern: .dashDot)
}

// Underline color can differ from the text color:
TappableText.Keyword("underline color is different") { }
    .color(.indigo)           // text is indigo
    .underlined(true, color: .pink, pattern: .solid)  // underline is pink
"""

    static let usageDescription = """
.underlined(_ isOn: Bool, color: Color? = nil, pattern: Text.LineStyle.Pattern = .solid)

- isOn: toggles underline on/off
- color: if nil, falls back to the keyword's foreground color
- pattern: .solid | .dash | .dot | .dashDot
"""

    var body: some View {
        ExampleContainer(
            title: "Underline Styles",
            description: "Every keyword supports solid, dash, dot, and dashDot underline patterns with custom colors.",
            usageCode: Self.usageCode,
            usageDescription: Self.usageDescription
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

                TappableText("Here underline color is different from the keyword text color itself.") {
                    TappableText.Keyword("underline color is different") {
                        showToast("different underline")
                    }
                    .color(.indigo)
                    .underlined(true, color: .pink, pattern: .solid)
                }
                .textFont(.system(size: 16))
            }
        }
    }
}
