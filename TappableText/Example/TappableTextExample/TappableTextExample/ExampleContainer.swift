//
//  ExampleContainer.swift
//  TappableTextExample
//
//  Created by Ian on 24/2/26.
//

import SwiftUI

protocol ExampleScreen: View {
    static var usageCode: String { get }
    static var usageDescription: String { get }
}

struct ExampleContainer<Content: View>: View {
    
    @Environment(\.colorScheme) private var colorScheme
    
    let title: String
    let description: String
    let usageCode: String
    let usageDescription: String
    @ViewBuilder let content: (_ showToast: @escaping (String) -> Void) -> Content

    @State private var toast: String? = nil
    @State private var showUsage = false

    private let impactFeedback = UIImpactFeedbackGenerator(style: .light)

    init(
        title: String,
        description: String,
        usageCode: String = "",
        usageDescription: String = "",
        @ViewBuilder content: @escaping (_ showToast: @escaping (String) -> Void) -> Content
    ) {
        self.title = title
        self.description = description
        self.usageCode = usageCode
        self.usageDescription = usageDescription
        self.content = content
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text(description)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .padding(.horizontal)

                content(showToast)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(
                        Color(colorScheme == .light ? .systemBackground : .systemGray6)
                            .shadow(.drop(color: Color(.label).opacity(0.08), radius: 8, y: 4))
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .padding(.horizontal)

                if !usageCode.isEmpty {
                    Button {
                        impactFeedback.impactOccurred()
                        showUsage = true
                    } label: {
                        Label("Show Usage", systemImage: "chevron.left.forwardslash.chevron.right")
                            .font(.subheadline.bold())
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.bordered)
                    .padding(.horizontal)
                }

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
        .sheet(isPresented: $showUsage) {
            UsageSheet(code: usageCode, description: usageDescription)
        }
    }

    private func showToast(_ message: String) {
        impactFeedback.impactOccurred()
        toast = message
        Task {
            try? await Task.sleep(for: .seconds(2))
            toast = nil
        }
    }
}

private struct UsageSheet: View {
    let code: String
    let description: String

    @Environment(\.dismiss) private var dismiss
    @State private var isCopied = false

    private let notificationFeedback = UINotificationFeedbackGenerator()

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    if !description.isEmpty {
                        Text(description)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .padding(.horizontal)
                    }

                    Text(code)
                        .font(.system(size: 13, design: .monospaced))
                        .padding(16)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color(.secondarySystemGroupedBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .padding(.horizontal)

                    Button {
                        UIPasteboard.general.string = code
                        notificationFeedback.notificationOccurred(.success)
                        withAnimation(.spring(duration: 0.3)) {
                            isCopied = true
                        }
                        Task {
                            try? await Task.sleep(for: .seconds(2))
                            withAnimation(.spring(duration: 0.3)) {
                                isCopied = false
                            }
                        }
                    } label: {
                        Label(
                            isCopied ? "Copied!" : "Copy Code",
                            systemImage: isCopied ? "checkmark" : "doc.on.doc"
                        )
                        .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.bordered)
                    .tint(isCopied ? .green : .accentColor)
                    .disabled(isCopied)
                    .padding(.horizontal)
                    .animation(.spring(duration: 0.3), value: isCopied)
                }
                .padding(.top, 12)
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Usage")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
        .presentationDetents([.medium, .large])
        .presentationDragIndicator(.visible)
    }
}
