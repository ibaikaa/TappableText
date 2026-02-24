//
//  ChatMentionExample.swift
//  TappableTextExample
//
//  Created by Ian on 24/2/26.
//

import SwiftUI
import TappableText

struct ChatMentionExample: View {

    static let usageCode = """
struct Message {
    let author, text: String
    let mentions: [String]
}

TappableText(message.text) {
    for mention in message.mentions {
        TappableText.Keyword(mention) {
            openProfile(mention)
        }
        .color(mention == "@Bot" ? .green : .blue)
        .font(.system(size: 15, weight: .semibold))
    }
}
.textFont(.system(size: 15))
"""

    static let usageDescription = """
TappableText's KeywordBuilder supports for loops natively — just add buildArray to your result builder.
Each mention gets its own keyword at runtime, with individual styling per name.
"""

    struct Message {
        let author, text: String
        let mentions: [String]
    }

    private let messages = [
        Message(
            author: "Alex",
            text: "Hey everyone! @Maria and @John, can you review the PR? @Bot please run the tests.",
            mentions: ["@Maria", "@John", "@Bot"]
        ),
        Message(
            author: "Maria",
            text: "Sure @Alex! I'll look at it after the standup. @John are you available?",
            mentions: ["@Alex", "@John"]
        ),
        Message(
            author: "John",
            text: "On it! @Bot please also check the linting.",
            mentions: ["@Bot"]
        ),
    ]

    var body: some View {
        ExampleContainer(
            title: "Real-World: Chat Mentions",
            description: "Mention highlighting inside chat bubbles — each @mention is a tappable keyword.",
            usageCode: Self.usageCode,
            usageDescription: Self.usageDescription
        ) { showToast in
            VStack(alignment: .leading, spacing: 12) {
                ForEach(messages, id: \.author) { message in
                    VStack(alignment: .leading, spacing: 4) {
                        Text(message.author)
                            .font(.caption.bold())
                            .foregroundStyle(.secondary)

                        TappableText(message.text) {
                            for mention in message.mentions {
                                let captured = mention
                                TappableText.Keyword(mention) {
                                    showToast("Profile: \(captured)")
                                }
                                .color(mention == "@Bot" ? .green : .blue)
                                .font(.system(size: 15, weight: .semibold))
                            }
                        }
                        .textFont(.system(size: 15))
                        .padding(10)
                        .background(Color(.secondarySystemGroupedBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
            }
        }
    }
}
