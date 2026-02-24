//
//  KitchenSinkExample.swift
//  TappableTextExample
//
//  Created by Ian on 24/2/26.
//

import SwiftUI
import TappableText

/// Everything at once: global defaults, per-keyword overrides, plain tap, mixed fonts.
struct KitchenSinkExample: View {
    var body: some View {
        ExampleContainer(
            title: "Kitchen Sink",
            description: "Everything combined: global defaults, individual overrides, mixed fonts, all underline patterns, and plain text tap."
        ) { showToast in
            VStack(alignment: .leading, spacing: 24) {
                
                // --- Block 1: global underline inherited by most, one overrides ---
                sectionLabel("Global underline inherited — one keyword overrides")
                
                TappableText("We value your trust, your security, and above all your freedom.") {
                    TappableText.Keyword("trust") {
                        showToast("trust")
                    }
                    // inherits global green + dash
                    
                    TappableText.Keyword("security") {
                        showToast("security")
                    }
                    .color(.blue)
                    .underlined(true, color: .blue, pattern: .dot)
                    // overrides color & underline
                    
                    TappableText.Keyword("freedom") {
                        showToast("freedom")
                    }
                    // inherits global green + dash
                }
                .textFont(.system(size: 16))
                .keywordColor(.green)
                .keywordUnderline(true, color: .green, pattern: .dash)
                .onPlainWordsTap {
                    showToast("plain word")
                }
                
                Divider()
                
                // --- Block 2: mixed font designs ---
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
                
                // --- Block 3: no styling at all on keywords, global takes over ---
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
                
                // --- Block 4: underline disabled per-keyword even though global is on ---
                sectionLabel("Global underline ON, but one keyword disables it")
                
                TappableText("Important notice: click here to upgrade or dismiss this message.") {
                    TappableText.Keyword("click here") {
                        showToast("click here")
                    }
                    .color(.blue)
                    // inherits global underline
                    
                    TappableText.Keyword("upgrade") {
                        showToast("upgrade")
                    }
                    .color(.green)
                    .underlined(false)
                    // explicitly turns OFF underline for this keyword
                    
                    TappableText.Keyword("dismiss") {
                        showToast("dismiss")
                    }
                    .color(.red)
                    // inherits global underline
                }
                .textFont(.system(size: 16))
                .keywordUnderline(true, color: .gray, pattern: .dash)
            }
        }
    }
    
    @ViewBuilder
    func sectionLabel(_ text: String) -> some View {
        Text(text)
            .font(.caption.bold())
            .foregroundStyle(.secondary)
    }
}
