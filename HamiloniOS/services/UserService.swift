//
//  UserService.swift
//  HamiloniOS
//
//  Created by 한설 on 7/31/25.
//

import Foundation

class UserService {
    func SignIn(id: String, password: String) async throws -> Bool {
        
        let response:Response<requestSignIn> = try await HttpNetworkObject.shared.postRequest(urlstring: "/user/signin", body: requestSignIn(id: id, password: password))
        switch response {
        case .json(let data):
            return true
        case .string(let message):
            return message == "true"
        }
    }
}
