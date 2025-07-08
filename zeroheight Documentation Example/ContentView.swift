//
//  ContentView.swift
//  zeroheight Documentation Example
//
//  Created by Seth Corker on 01/07/2025.
//

import SwiftUI

struct ContentView: View {
    let ComponentDocumentation = [
        DocumentedComponent(
            name: "Primary Button",
            documentationID: "18cce4",
            view: AnyView(
                PrimaryButton(
                    text: "Greeting",
                    action: {
                        print("action")
                    }
                )
            )
        ),
        DocumentedComponent(
            name: "Toggle",
            documentationID: "2166a9",
            view: AnyView(
                VStack {
                    Toggle(isOn: .constant(false)) {
                        Text("Enable")
                    }.toggleStyle(BrandedToggleStyle())
                    Toggle(isOn: .constant(true)) {
                        Text("Enable")
                    }.toggleStyle(BrandedToggleStyle())
                }.padding()
            )
        ),
    ]

    @State var displayDocumentation = false
    @State var displayAuthForm = false
    @State var activeComponentUUID: UUID? = nil

    var activeComponent: DocumentedComponent {
        ComponentDocumentation.first(where: { el in
            el.id == activeComponentUUID
        }) ?? ComponentDocumentation.first!
    }

    var body: some View {
        NavigationSplitView {
            List(ComponentDocumentation, selection: $activeComponentUUID) {
                documentedComponent in
                NavigationLink(
                    documentedComponent.name,
                    value: documentedComponent.id
                )
            }
            #if os(iOS)
            .toolbar {
                Button {
                    displayAuthForm = true
                } label: {
                    Image(systemName: "lock")
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            #endif
            .navigationTitle("Components")

        } content: {
            VStack(alignment: .leading) {
                activeComponent.view
                    .padding(50)
                    
                Spacer()
            }
            .navigationTitle(activeComponent.name)
            #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button {
                    displayDocumentation = true
                } label: {
                    Image(systemName: "text.document")
                }
                
            }
            #elseif os(macOS)
            .toolbar {
                Button {
                    displayAuthForm = true
                } label: {
                    Image(systemName: "lock")
                }
            }
            #endif
            .toolbarTitleDisplayMode(.inlineLarge)
        } detail: {
            #if os(iOS)
            Text("Choose a component")
            #elseif os(macOS)
            DocumentationView(id: activeComponent.documentationID)
            #endif
        }
        .sheet(isPresented: $displayDocumentation) {
            displayDocumentation = false
        } content: {
            DocumentationView(id: activeComponent.documentationID)
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(.visible)
                .presentationContentInteraction(.scrolls)
        }
        .sheet(isPresented: $displayAuthForm) {
            displayAuthForm = false
        } content: {
            AuthCredentialsView()
                .presentationDetents([.height(150)])
                .presentationDragIndicator(.hidden)
        }
    }
}

#Preview {
    ContentView()
}
