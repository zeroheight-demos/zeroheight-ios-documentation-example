//
//  DocumentedComponent.swift
//  zeroheight Documentation Example
//
//  Created by Seth Corker on 01/07/2025.
//

import Foundation
import SwiftUI

struct DocumentedComponent : Identifiable {
    let id = UUID()
    let name: String
    let documentationID: String // UID for the page in zeroheight
    let view: AnyView
}
