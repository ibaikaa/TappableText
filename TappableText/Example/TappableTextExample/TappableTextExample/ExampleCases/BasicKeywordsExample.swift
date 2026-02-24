//
//  BasicKeywordsExample.swift
//  TappableTextExample
//
//  Created by Ian on 24/2/26.
//

import SwiftUI
import TappableText

struct BasicKeywordsExample: View {

    static let usageCode = """
TappableText("Please read our Terms of Service and Privacy Policy before continuing.") {
    TappableText.Keyword("Terms of Service") {
        // handle tap
    }
    TappableText.Keyword("Privacy Policy") {
        // handle tap
    }
}
.textFont(.system(size: 16))
"""

    static let usageDescription = "The minimal setup — just pass keywords with closures. No extra styling required. Keywords inherit the default blue color automatically."

    var body: some View {
        ExampleContainer(
            title: "Basic Keywords",
            description: "The minimal setup. Keywords get the default blue color automatically.",
            usageCode: Self.usageCode,
            usageDescription: Self.usageDescription
        ) { showToast in
            TappableText("Please read our Terms of Service and Privacy Policy before continuing.") {
                TappableText.Keyword("Terms of Service") {
                    showToast("Terms of Service")
                }

                TappableText.Keyword("Privacy Policy") {
                    showToast("Privacy Policy")
                }
            }
            .textFont(.system(size: 16))
        }
    }
}
