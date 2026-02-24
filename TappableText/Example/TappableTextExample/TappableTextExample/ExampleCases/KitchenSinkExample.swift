//
//  KitchenSinkExample.swift
//  TappableTextExample
//
//  Created by Ian on 24/2/26.
//

import SwiftUI
import TappableText

struct KitchenSinkExample: View {

    static let usageCode = """
// 1. Global underline — keywords inherit or override
TappableText("We value your trust, your security, and above all your freedom.") {
    TappableText.Keyword("trust") { }           // inherits global
    TappableText.Keyword("security") { }        // overrides
        .color(.blue)
        .underlined(true, color: .blue, pattern: .dot)
    TappableText.Keyword("freedom") { }         // inherits global
}
.keywordColor(.green)
.keywordUnderline(true, color: .green, pattern: .dash)
.onPlainWordsTap { }

// 2. Mixed font designs
TappableText("Code in monospaced, dream in serif, and ship in rounded.") {
    TappableText.Keyword("monospaced") { }
        .font(.system(size: 16, design: .monospaced))
    TappableText.Keyword("serif") { }
        .font(.system(size: 16, design: .serif))
    TappableText.Keyword("rounded") { }
        .font(.system(size: 16, weight: .bold, design: .rounded))
}

// 3. All keywords use global — no per-keyword styling
TappableText("Tap Login, Register, or Forgot Password to continue.") {
    TappableText.Keyword("Login") { }
    TappableText.Keyword("Register") { }
    TappableText.Keyword("Forgot Password") { }
}
.keywordColor(.accentColor)
.keywordUnderline(true, pattern: .solid)

// 4. Global underline ON, one keyword explicitly disables it
TappableText.Keyword("upgrade") { }
    .underlined(false)   // ← turns off for this keyword only
"""

    static let usageDescription = "All features in one place: global defaults, per-keyword overrides, .onPlainWordsTap, mixed font designs, and explicit underline opt-out."

    var body: some View {
        ExampleContainer(
            title: "Kitchen Sink",
            description: "Everything combined: global defaults, individual overrides, mixed fonts, all underline patterns, and plain text tap.",
            usageCode: Self.usageCode,
            usageDescription: Self.usageDescription
        ) { showToast in
            VStack(alignment: .leading, spacing: 24) {
                sectionLabel("Global underline inherited — one keyword overrides")

                TappableText("We value your trust, your security, and above all your freedom.") {
                    TappableText.Keyword("trust") {
                        showToast("trust")
                    }

                    TappableText.Keyword("security") {
                        showToast("security")
                    }
                    .color(.blue)
                    .underlined(true, color: .blue, pattern: .dot)

                    TappableText.Keyword("freedom") {
                        showToast("freedom")
                    }
                }
                .textFont(.system(size: 16))
                .keywordColor(.green)
                .keywordUnderline(true, color: .green, pattern: .dash)
                .onPlainWordsTap {
                    showToast("plain word")
                }

                Divider()

                sectionLabel("Mixed font designs per keyword")

                TappableText("Code in monospaced, dream in serif, and ship in rounded.") {
                    TappableText.Keyword("monospaced") {
                        showToast("mono")
                    }
                    .color(.cyan)
                    .font(.system(size: 16, design: .monospaced))
                    .underlined(true, color: .cyan, pattern: .solid)

                    TappableText.Keyword("serif") {
                        showToast("serif")
                    }
                    .color(.brown)
                    .font(.system(size: 16, design: .serif))
                    .underlined(true, color: .brown, pattern: .dashDot)

                    TappableText.Keyword("rounded") {
                        showToast("rounded")
                    }
                    .color(.orange)
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .underlined(true, color: .orange, pattern: .dot)
                }
                .textFont(.system(size: 16))

                Divider()

                sectionLabel("All keywords use global style (no per-keyword styling)")

                TappableText("Tap Login, Register, or Forgot Password to continue.") {
                    TappableText.Keyword("Login") {
                        showToast("Login")
                    }
                    TappableText.Keyword("Register") {
                        showToast("Register")
                    }
                    TappableText.Keyword("Forgot Password") {
                        showToast("Forgot Password")
                    }
                }
                .textFont(.system(size: 16))
                .keywordColor(.accentColor)
                .keywordUnderline(true, pattern: .solid)

                Divider()

                sectionLabel("Global underline ON, but one keyword disables it")

                TappableText("Important notice: click here to upgrade or dismiss this message.") {
                    TappableText.Keyword("click here") {
                        showToast("click here")
                    }
                    .color(.blue)

                    TappableText.Keyword("upgrade") {
                        showToast("upgrade")
                    }
                    .color(.green)
                    .underlined(false)

                    TappableText.Keyword("dismiss") {
                        showToast("dismiss")
                    }
                    .color(.red)
                }
                .textFont(.system(size: 16))
                .keywordUnderline(true, color: .gray, pattern: .dash)
            }
        }
    }

    @ViewBuilder
    private func sectionLabel(_ text: String) -> some View {
        Text(text)
            .font(.caption.bold())
            .foregroundStyle(.secondary)
    }
}
