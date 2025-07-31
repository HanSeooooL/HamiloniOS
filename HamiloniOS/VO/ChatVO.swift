//
//  ChatVO.swift
//  HamiloniOS
//
//  Created by 한설 on 2025/07/29.
//

import Foundation


class ChatVO {
    var author: String
    var content: String
    var timestamp: Date
    
    init(author: String, content: String, timestamp: Date) {
        self.author = author
        self.content = content
        self.timestamp = timestamp
    }
    
    init(author: String, content: String) {
        self.author = author
        self.content = content
        self.timestamp = Date()
    }
    
    init(chat: Chat) {
        self.author = chat.author
        self.content = chat.message
        self.timestamp = chat.timestamp
    }
}

extension ChatVO: Hashable {
    static func == (lhs: ChatVO, rhs: ChatVO) -> Bool {
        return lhs.author == rhs.author && lhs.content == rhs.content && lhs.timestamp == rhs.timestamp
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(author)
        hasher.combine(timestamp)
        hasher.combine(content)
    }
    
    
}

struct Chat: Codable {
    var author: String
    var message: String
    var timestamp: Date
    
    init (author: String, content: String) {
        self.author = author
        self.message = content
        self.timestamp = Date()
    }
    
    init (author: String, content: String, timestamp: String) {
        self.author = author
        self.message = content
        self.timestamp = Date()
    }
    
    func print() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        Swift.print("author: " + self.author)
        Swift.print("message: " + self.message)
        Swift.print("timestamp: " + dateFormatter.string(from: self.timestamp))
    }
}
