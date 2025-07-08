//
//  BrandedToggleStyle.swift
//  zeroheight Documentation Example
//
//  Created by Seth Corker on 01/07/2025.
//

import SwiftUI

struct BrandedToggleStyle: ToggleStyle {
    var systemImage: String = "checkmark"
    var activeColor: Color = .orange
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label

            Spacer()

            RoundedRectangle(cornerRadius: 10)
                .fill(configuration.isOn ? activeColor : Color.gray)
                .overlay {
                    RoundedRectangle(cornerRadius: 10.0)
                        .fill(.white)
                        .frame(width: 35, height: 30)
                        .overlay {
                            Image(systemName: systemImage)
                                .foregroundColor(
                                    configuration.isOn
                                        ? activeColor : Color.gray
                                )
                        }
                        .shadow(color: .black.opacity(0.3), radius: 1.0)
                        .offset(x: configuration.isOn ? 20 : -20)

                }
                .frame(width: 80, height: 35)
                .onTapGesture {
                    withAnimation(.spring()) {
                        configuration.isOn.toggle()
                    }
                }
        }
    }
}

#Preview {
    @Previewable @State var isOn: Bool = false
    
    Toggle(isOn: $isOn) {
        Text("Enable")
    }.toggleStyle(BrandedToggleStyle())
}

