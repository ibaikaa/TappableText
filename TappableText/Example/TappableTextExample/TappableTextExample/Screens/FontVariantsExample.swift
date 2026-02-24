//
//  FontVariantsExample.swift
//  TappableTextExample
//
//  Created by Ian on 24/2/26.
//

import SwiftUI
import TappableText

/// Demonstrating how .font() on a keyword allows bold, italic, rounded, monospaced, etc.
struct FontVariantsExample: View {
    var body: some View {
        ExampleContainer(
            title: "Font Variants",
            description: "Use .font() per keyword to apply bold, italic, monospaced, rounded, and other font designs within the same text."
        ) { showToast in
            VStack(alignment: .leading, spacing: 20) {
                TappableText("This text has bold, italic, mono, and rounded keywords all together.") {
                    TappableText.Keyword("bold") {
                        showToast("bold")
                    }
                    .color(.blue)
                    .font(.system(size: 16, weight: .bold))
                    
                    TappableText.Keyword("italic") {
                        showToast("italic")
                    }
                    .color(.indigo)
                    .font(.system(size: 16, weight: .regular).italic())
                    
                    TappableText.Keyword("mono") {
                        showToast("mono")
                    }
                    .color(.green)
                    .font(.system(size: 16, design: .monospaced))
                    
                    TappableText.Keyword("rounded") {
                        showToast("rounded")
                    }
                    .color(.orange)
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                }
                .textFont(.system(size: 16))
                
                Divider()
                
                // Serif design
                TappableText("Combine serif elegance with modern sans and dramatic heavy weight.") {
                    TappableText.Keyword("serif elegance") {
                        showToast("serif")
                    }
                    .color(.brown)
                    .font(.system(size: 16, design: .serif))
                    
                    TappableText.Keyword("modern sans") {
                        showToast("sans")
                    }
                    .color(.cyan)
                    .font(.system(size: 16, weight: .medium))
                    
                    TappableText.Keyword("dramatic heavy") {
                        showToast("heavy")
                    }
                    .color(.red)
                    .font(.system(size: 18, weight: .black))
                }
                .textFont(.system(size: 16))
                
                Divider()
                
                codeHint("""
.font(.system(size: 16, weight: .bold))
.font(.system(size: 16, weight: .regular).italic())
.font(.system(size: 16, design: .monospaced))
.font(.system(size: 16, design: .rounded))
.font(.system(size: 16, design: .serif))
""")
            }
        }
    }
}
