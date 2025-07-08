//
//  DismissButton.swift
//  zeroheight Documentation Example
//
//  Created by Seth Corker on 01/07/2025.
//

import SwiftUI

struct DismissButton: View {
    let action: () -> Void

    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: "xmark.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .foregroundColor(.gray.opacity(0.5))
        }
    }
}

#Preview {
    DismissButton(action: {})
}
