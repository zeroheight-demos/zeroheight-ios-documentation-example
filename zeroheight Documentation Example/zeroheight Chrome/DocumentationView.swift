//
//  DocumentationView.swift
//  zeroheight Documentation Example
//
//  Created by Seth Corker on 01/07/2025.
//

import MarkdownUI
import SwiftUI

struct DocumentationView: View {
    var id: String
    
    @Environment(\.dismiss) private var dismiss
    
    @State var page: ZHPage?
    @State var errorMessage: String?
    
    func openUrl(_ url: URL) {
        #if os(iOS)
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else {
            print("Invalid url")
        }
        #elseif os(macOS)
        NSWorkspace.shared.open(url)
        #endif
    }

    func getDocumentation() async {
        do {
            errorMessage = nil
            let (data, _) = try await APIService.request(
                "pages/\(id)/?format=markdown"
            )

            let decoder = JSONDecoder()
            let pageResponse = try decoder.decode(
                ZHPageResponse.self,
                from: data
            )

            page = pageResponse.data.page
        } catch {
            errorMessage =
                "Failed to get documentation. Check your auth credentials and try again."
            print("Error: \(error)")
        }
    }

    var body: some View {
        NavigationStack {
            VStack {
                if let message = errorMessage {
                    VStack(alignment: .center) {
                        Image(systemName: "text.page.badge.magnifyingglass")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .foregroundStyle(.primary)
                        Text(message).font(.headline).multilineTextAlignment(.center)
                    }
                    .padding()
                } else if let page = page {
                    ScrollView {
                        Markdown(page.content)
                            .padding()
                    }
                } else {
                    ProgressView("Loading")
                        .task {
                            await getDocumentation()
                        }
                }
            }
            .onChange(of: id, { oldValue, newValue in
                if oldValue == newValue {
                    return
                }
                
                Task {
                    page = nil
                    await getDocumentation()
                }
            })
            .navigationTitle("Documentation")
            #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
            #endif
            .toolbar {
                if let page = page, let url = URL(string: page.url) {
                    Button {
                        openUrl(url)
                    } label: {
                        Image(systemName: "link")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.blue)
                    }
                }
                #if os(iOS)
                DismissButton(action: {
                    dismiss()
                })
                #endif
            }
        }
    }
}

#Preview {
    DocumentationView(id: "18cce4")
}
