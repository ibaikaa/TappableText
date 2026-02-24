//
//  LegalAgreementExample.swift
//  TappableTextExample
//
//  Created by Ian on 24/2/26.
//

import SwiftUI
import TappableText

struct LegalAgreementExample: View {

    static let usageCode = """
TappableText(
    "By tapping Agree, you accept our Terms of Service, acknowledge our Privacy Policy, and consent to the Cookie Policy."
) {
    TappableText.Keyword("Terms of Service") { openTerms() }
        .color(.accentColor)
        .underlined(true, pattern: .solid)

    TappableText.Keyword("Privacy Policy") { openPrivacy() }
        .color(.accentColor)
        .underlined(true, pattern: .solid)

    TappableText.Keyword("Cookie Policy") { openCookies() }
        .color(.accentColor)
        .underlined(true, pattern: .solid)
}
.textFont(.system(size: 14))
.textColor(.secondary)
"""

    static let usageDescription = "A common onboarding pattern. Use .textColor(.secondary) to dim the legal text while keeping tappable links visually prominent."

    @State private var agreed = false

    var body: some View {
        ExampleContainer(
            title: "Real-World: Legal Agreement",
            description: "A typical onboarding pattern — inline tappable links inside legal consent text.",
            usageCode: Self.usageCode,
            usageDescription: Self.usageDescription
        ) { showToast in
            VStack(alignment: .leading, spacing: 20) {
                TappableText(
                    "By tapping Agree, you accept our Terms of Service, acknowledge our Privacy Policy, and consent to the Cookie Policy."
                ) {
                    TappableText.Keyword("Terms of Service") {
                        showToast("Terms of Service →")
                    }
                    .color(.accentColor)
                    .underlined(true, pattern: .solid)

                    TappableText.Keyword("Privacy Policy") {
                        showToast("Privacy Policy →")
                    }
                    .color(.accentColor)
                    .underlined(true, pattern: .solid)

                    TappableText.Keyword("Cookie Policy") {
                        showToast("Cookie Policy →")
                    }
                    .color(.accentColor)
                    .underlined(true, pattern: .solid)
                }
                .textFont(.system(size: 14))
                .textColor(.secondary)

                Button {
                    agreed.toggle()
                    if agreed {
                        showToast("Agreed! ✅")
                    }
                } label: {
                    Text(agreed ? "Agreed ✅" : "Agree")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .disabled(agreed)
            }
        }
    }
}
