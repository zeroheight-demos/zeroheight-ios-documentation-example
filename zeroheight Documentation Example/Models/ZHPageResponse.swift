//
//  ZHPageResponse.swift
//  zeroheight Documentation Example
//
//  Created by Seth Corker on 01/07/2025.
//

import Foundation

struct ZHPage : Codable{
    let id: Int
    let content: String
    let url: String
}

struct ZHPageWrapperResponse : Codable {
    let page: ZHPage
}

struct ZHPageResponse : Codable {
    let status: String
    let data: ZHPageWrapperResponse
}
