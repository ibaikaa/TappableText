//
//  GlobalVsOverrideExample.swift
//  TappableTextExample
//
//  Created by Ian on 24/2/26.
//

import SwiftUI
import TappableText

/// Global defaults set on TappableText, individual keywords selectively override.
struct GlobalVsOverrideExample: View {
    var body: some View {
        ExampleContainer(
            title: "Global vs Override",
            description: "Set global defaults on TappableText. Individual keywords override only what they need — the rest inherits."
        ) { showToast in
            VStack(alignment: .leading, spacing: 16) {
                // All keywords inherit .teal and dash underline by default
                // "special offer" overrides just the color to .pink
                TappableText("Enjoy free shipping, a special offer, and cashback rewards on every order.") {
                    TappableText.Keyword("free shipping") {
                        showToast("Free Shipping")
                    }
                    // ↑ inherits global teal + dash underline
                    
                    TappableText.Keyword("special offer") {
                        showToast("Special Offer")
                    }
                    .color(.pink)
                    .underlined(true, color: .pink, pattern: .dashDot)
                    // ↑ overrides color & underline pattern
                    
                    TappableText.Keyword("cashback rewards") {
                        showToast("Cashback")
                    }
                    // ↑ inherits global teal + dash underline
                }
                .textFont(.system(size: 16))
                .keywordColor(.teal)
                .keywordUnderline(true, color: .teal, pattern: .dash)
                
                Divider()
                
                VStack(alignment: .leading, spacing: 4) {
                    Label(
                        "free shipping — inherits global teal",
                        systemImage: "arrow.down.right"
                    )
                    .font(.caption).foregroundStyle(.teal)
                    
                    Label(
                        "special offer — overrides to pink + dashDot",
                        systemImage: "arrow.down.right"
                    )
                    .font(.caption).foregroundStyle(.pink)
                    
                    Label(
                        "cashback rewards — inherits global teal",
                        systemImage: "arrow.down.right"
                    )
                    .font(.caption).foregroundStyle(.teal)
                }
                
                Divider()
                
                codeHint("""
.keywordColor(.teal)
.keywordUnderline(true, color: .teal, pattern: .dash)
// "special offer" overrides independently
""")
            }
        }
    }
}
