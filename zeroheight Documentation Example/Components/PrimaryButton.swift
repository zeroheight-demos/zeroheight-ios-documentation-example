//
//  PrimaryButton.swift
//  zeroheight Documentation Example
//
//  Created by Seth Corker on 01/07/2025.
//

import SwiftUI

struct PrimaryButton: View {
    let text: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(text)
                .foregroundStyle(.white)
                .padding(EdgeInsets(top: 10, leading: 50, bottom: 10, trailing: 50))
                .background(Color.orange)
                .clipShape(.capsule)
                .shadow(color: Color.orange.opacity(0.5), radius: 25.0)
        }
    }
}

#Preview {
    PrimaryButton(text: "Greeting") {
        print("Hello")
    }
}
