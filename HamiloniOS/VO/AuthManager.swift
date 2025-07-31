//
//  AuthManager.swift
//  HamiloniOS
//
//  Created by 한설 on 7/31/25.
//

import Foundation

@MainActor
final class AuthManager: ObservableObject {
    @Published var isLoggedIn = false
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var user: UserVO?
    
    init(isLoggedIn: Bool = false, isLoading: Bool = false, errorMessage: String? = nil, user: UserVO? = nil) {
        self.isLoggedIn = isLoggedIn
        self.isLoading = isLoading
        self.errorMessage = errorMessage
        self.user = user
    }
    
    func login(id: String, password: String) async throws -> Bool {
        isLoading = true
        errorMessage = nil
        
        do {
            let response:Response<responseSignIn> = try await HttpNetworkObject.shared.postRequest(urlstring: "/user/signin", body: requestSignIn(id: id, password: password))
            switch response {
            case .json(let data):
                if data.id == id {
                    self.user = UserVO(id: data.id, nickname: data.nickname, age: data.age, mail: data.mail)
                    self.isLoggedIn = true
                    self.isLoading = false
                    return true
                } else {
                    print("로그인 실패")
                    self.isLoading = false
                    return false
                }
                        
            case .string(let message):
                throw NetworkError.unsupportedResponse
            }
        }
    }
}

