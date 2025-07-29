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
    var timestamp: String
    
    init(author: String, content: String, timestamp: String) {
        self.author = author
        self.content = content
        self.timestamp = timestamp
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
