//
//  ChatService.swift
//  HamiloniOS
//
//  Created by 한설 on 7/30/25.
//

import Foundation

class ChatService {
    func testRequest() async -> String {
        do {
            let response: Response<String> = try await HttpNetworkObject.shared.getRequest(urlstring: "/chat/test")
            switch response {
            case .json(let data):
                return data
            case .string(let message):
                return message
            }
        } catch {
            print("Error")
        }
        return ""
    }
    
    func sendChat(chat: Chat) async throws -> Chat {
        var result: Chat
        do {
            let response: Response<Chat> = try await HttpNetworkObject.shared.postRequest(urlstring: "/chat/send", body: chat)
            switch response {
            case .json(let data):
                result = data
            case .string(_):
                throw ChatServiceError.FileTypeError
            }
        } catch {
            throw ChatServiceError.ResponseError
        }
        
        return result
    }
}

enum ChatServiceError: Error {
    case FileTypeError
    case ResponseError
}
