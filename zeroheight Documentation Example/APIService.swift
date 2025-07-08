//
//  APIService.swift
//  zeroheight Documentation Example
//
//  Created by Seth Corker on 01/07/2025.
//

import Foundation
import KeychainSwift

struct APIService {
    static func retrieveCredentials() -> (String?, String?) {
        let keychain = KeychainSwift()
        let storedClientId = keychain.get("clientId")
        let storedAccessToken = keychain.get("accessToken")
        
        return (storedClientId, storedAccessToken)
    }
    
    static func request(_ path: String) async throws -> (Data, URLResponse) {
        let credentials = retrieveCredentials()
        
        let url = URL(string: "https://zeroheight.com/open_api/v2/\(path)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(credentials.0, forHTTPHeaderField: "X-API-CLIENT")
        request.setValue(credentials.1, forHTTPHeaderField: "X-API-KEY")
        
        return try await withCheckedThrowingContinuation { continuation in
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }
                guard let data = data, let response = response else {
                    continuation.resume(throwing: URLError(.badServerResponse))
                    return
                }
                continuation.resume(returning: (data, response))
            }.resume()
        }
    }
    
    static var DefaultDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        return formatter
    }
}
