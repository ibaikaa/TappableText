//
//  ExampleContainer.swift
//  TappableTextExample
//
//  Created by Ian on 24/2/26.
//

import SwiftUI

/// Wraps an example view with a card-style container and a toast for showing tapped phrase.
struct ExampleContainer<Content: View>: View {
    let title: String
    let description: String
    @ViewBuilder let content: (_ showToast: @escaping (String) -> Void) -> Content

    @State private var toast: String? = nil

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text(description)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .padding(.horizontal)

                content(showToast)  // ← передаём сюда
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(.background.shadow(.drop(color: .black.opacity(0.08), radius: 8, y: 4)))
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .padding(.horizontal)

                if let toast {
                    HStack(spacing: 8) {
                        Image(systemName: "hand.tap.fill")
                        Text("Tapped: \"\(toast)\"")
                            .bold()
                    }
                    .font(.subheadline)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                    .background(Color.accentColor)
                    .foregroundStyle(.white)
                    .clipShape(Capsule())
                    .padding(.horizontal)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                }

                Spacer(minLength: 40)
            }
            .padding(.top, 12)
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
        .animation(.spring(duration: 0.3), value: toast)
    }

    private func showToast(_ message: String) {
        toast = message
        Task {
            try? await Task.sleep(for: .seconds(2))
            toast = nil
        }
    }
}
