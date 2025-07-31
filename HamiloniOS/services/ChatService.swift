//
//  ChatService.swift
//  HamiloniOS
//
//  Created by 한설 on 7/30/25.
//

import Foundation

@MainActor
class ChatViewModel: ObservableObject {
    
    @Published var chatlist: Array<ChatVO> = []
    
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
    
    func initMessageHistory() async throws {
        do {
            let response: Response<Array<Chat>> = try await HttpNetworkObject.shared.getRequest(urlstring: "/chat/startchat")
            switch response {
            case .json(let data):
                for chat in chatlist {
                    chatlist.append(ChatVO(author: chat.author, content: chat.content, timestamp: chat.timestamp))
                }
            case .string(let message):
            }
        }
    }
    
    func sendChat(chat: Chat) async throws {
        var res: Chat
        
        chatlist.append(ChatVO(chat: chat))
        do {
            let response: Response<Chat> = try await HttpNetworkObject.shared.postRequest(urlstring: "/chat/send", body: chat)
            switch response {
            case .json(let data):
                res = data
                self.chatlist.append(ChatVO(chat: res))
            case .string(_):
                throw ChatServiceError.FileTypeError
            }
        } catch {
            throw ChatServiceError.ResponseError
        }
    }
}

enum ChatServiceError: Error {
    case FileTypeError
    case ResponseError
}
