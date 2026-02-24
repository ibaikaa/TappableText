//
//  View+CodeHint.swift
//  TappableTextExample
//
//  Created by Ian on 24/2/26.
//

import SwiftUI

extension View {
    @ViewBuilder
    func codeHint(_ code: String) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Label("Usage", systemImage: "chevron.left.forwardslash.chevron.right")
                .font(.caption.bold())
                .foregroundStyle(.secondary)

            Text(code)
                .font(.system(size: 11, design: .monospaced))
                .foregroundStyle(.secondary)
                .padding(10)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(.secondarySystemGroupedBackground))
                .clipShape(RoundedRectangle(cornerRadius: 8))
        }
    }
}
