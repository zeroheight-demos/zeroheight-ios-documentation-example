//
//  ZHPageResponse.swift
//  zeroheight Documentation Example
//
//  Created by Seth Corker on 01/07/2025.
//

import Foundation

// Zeroheight page
struct ZHPage : Codable{
    let id: Int
    let content: String
    let url: String
}

// Wrapping structure
struct ZHPageWrapperResponse : Codable {
    let page: ZHPage
}

// Successful response from the zeroheight API
struct ZHPageResponse : Codable {
    let status: String
    let data: ZHPageWrapperResponse
}
