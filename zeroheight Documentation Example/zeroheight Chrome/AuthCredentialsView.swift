//
//  AuthCredentialsView.swift
//  zeroheight Documentation Example
//
//  Created by Seth Corker on 01/07/2025.
//

import KeychainSwift
import SwiftUI

struct AuthCredentialsView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var accessToken: String = ""
    @State private var clientId: String = ""
    @State private var presentResetConfirmation = false

    let keychain = KeychainSwift()

    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    TextField("Client ID", text: $clientId)
                    SecureField("Access Token", text: $accessToken)
                }
                .formStyle(.columns)
                .padding(
                    EdgeInsets.init(
                        top: 0,
                        leading: 10,
                        bottom: 0,
                        trailing: 10
                    )
                )
                HStack(spacing: 30) {
                    Button("Reset", role: .destructive) {
                        presentResetConfirmation = true
                    }
                    .confirmationDialog(
                        "Are your sure you want to reset your credentials?",
                        isPresented: $presentResetConfirmation
                    ) {
                        Button("Reset credentials", role: .destructive) {
                            keychain.delete("accessToken")
                            keychain.delete("clientId")
                        }
                    } message: {
                        Text("You can get new API credentials from your organization settings.")
                    }

                    Button("Login") {
                        keychain.set(accessToken, forKey: "accessToken")
                        keychain.set(clientId, forKey: "clientId")
                        dismiss()
                    }
                    .buttonStyle(.borderedProminent)
                }

                Spacer()
            }
            .onAppear {
                if let value = keychain.get("clientId") {
                    clientId = value
                }

                if let value = keychain.get("accessToken") {
                    accessToken = value
                }
            }
            .navigationTitle("zeroheight credentials")
            #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                DismissButton {
                    dismiss()
                }
            }
            #endif
        }
    }
}

#Preview {
    AuthCredentialsView()
}
