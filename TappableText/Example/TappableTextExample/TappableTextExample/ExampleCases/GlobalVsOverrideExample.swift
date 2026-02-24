//
//  GlobalVsOverrideExample.swift
//  TappableTextExample
//
//  Created by Ian on 24/2/26.
//

import SwiftUI
import TappableText

struct GlobalVsOverrideExample: View {

    static let usageCode = """
TappableText("Enjoy free shipping, a special offer, and cashback rewards on every order.") {
    // Inherits global .teal + .dash
    TappableText.Keyword("free shipping") { }

    // Overrides color and underline pattern only
    TappableText.Keyword("special offer") { }
        .color(.pink)
        .underlined(true, color: .pink, pattern: .dashDot)

    // Inherits global .teal + .dash
    TappableText.Keyword("cashback rewards") { }
}
.keywordColor(.teal)
.keywordUnderline(true, color: .teal, pattern: .dash)
"""

    static let usageDescription = """
.keywordColor() and .keywordUnderline() set the defaults for ALL keywords.
A keyword that calls .color() or .underlined() overrides only its own property — everything else still inherits from the global.
"""

    var body: some View {
        ExampleContainer(
            title: "Global vs Override",
            description: "Set global defaults on TappableText. Individual keywords override only what they need — the rest inherits.",
            usageCode: Self.usageCode,
            usageDescription: Self.usageDescription
        ) { showToast in
            VStack(alignment: .leading, spacing: 16) {
                TappableText("Enjoy free shipping, a special offer, and cashback rewards on every order.") {
                    TappableText.Keyword("free shipping") {
                        showToast("Free Shipping")
                    }

                    TappableText.Keyword("special offer") {
                        showToast("Special Offer")
                    }
                    .color(.pink)
                    .underlined(true, color: .pink, pattern: .dashDot)

                    TappableText.Keyword("cashback rewards") {
                        showToast("Cashback")
                    }
                }
                .textFont(.system(size: 16))
                .keywordColor(.teal)
                .keywordUnderline(true, color: .teal, pattern: .dash)

                VStack(alignment: .leading, spacing: 4) {
                    Label("free shipping — inherits global teal", systemImage: "arrow.down.right")
                        .font(.caption).foregroundStyle(.teal)

                    Label("special offer — overrides to pink + dashDot", systemImage: "arrow.down.right")
                        .font(.caption).foregroundStyle(.pink)

                    Label("cashback rewards — inherits global teal", systemImage: "arrow.down.right")
                        .font(.caption).foregroundStyle(.teal)
                }
            }
        }
    }
}
