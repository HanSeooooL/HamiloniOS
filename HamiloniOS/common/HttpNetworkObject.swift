//
//  HttpNetworkObject.swift
//  HamiloniOS
//
//  Created by 한설 on 7/30/25.
//

import Foundation

class HttpNetworkObject {
    nonisolated(unsafe) static let shared = HttpNetworkObject()
    
    private var based_url = "http://127.0.0.1:5000"
    
    private init() {}
    
    func getRequest<T: Decodable>(urlstring: String) async throws -> Response<T> {
        let tmpurl = based_url + urlstring
        guard let url = URL(string: tmpurl) else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              let contentType = httpResponse.value(forHTTPHeaderField: "Content-Type") else {
                  throw NetworkError.unsupportedResponse
              }
        
        if contentType.contains("application/json") {
            do {
                var json = try JSONDecoder().decode(T.self, from: data)
                return .json(json)
            } catch {
                print("GET decode error:", error)
                throw NetworkError.decodingFailed
            }
        } else {
            guard let string = String(data: data, encoding: .utf8) else {
                throw NetworkError.decodingFailed
            }
            return .string(string)
        }
    }
    
    func postRequest<T:Decodable, U: Encodable>(urlstring: String, body: U) async throws -> Response<T> {
        let tmpurl = based_url + urlstring
        guard let url = URL(string: tmpurl) else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpBody = try JSONEncoder().encode(body)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              let contentType = httpResponse.value(forHTTPHeaderField: "Content-Type") else {
            throw NetworkError.unsupportedResponse
        }
        
        if contentType.contains("application/json") {
            do {
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                formatter.timeZone = TimeZone(secondsFromGMT: 0)
                
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(formatter)
                
                let json = try decoder.decode(T.self, from: data)
                return .json(json)
            } catch {
                print("GET decode error:", error)
                throw NetworkError.decodingFailed
            }
        } else {
            guard let string = String(data: data, encoding: .utf8) else {
                throw NetworkError.decodingFailed
            }
            return .string(string)
        }
    }
}

enum Response<T:Decodable & Sendable>: Sendable {
    case json(T)
    case string(String)
}

enum NetworkError: Error {
    case invalidURL
    case requestFailed
    case decodingFailed
    case unsupportedResponse
}
