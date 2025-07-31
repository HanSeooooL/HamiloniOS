//
//  UserVO.swift
//  HamiloniOS
//
//  Created by 한설 on 7/31/25.
//

import Foundation

class UserVO{
    var id: String
    var nickname: String
    var age: Int
    var mail: String
    
    init(id: String, nickname: String, age: Int, mail: String) {
        self.id = id
        self.nickname = nickname
        self.age = age
        self.mail = mail
    }
}


struct requestSignIn: Encodable {
    var id: String
    var password: String
}

struct responseSignIn: Decodable, Sendable {
    var id: String
    var nickname: String
    var age: Int
    var mail: String
}
