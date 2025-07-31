//
//  SignInView.swift
//  HamiloniOS
//
//  Created by 한설 on 7/31/25.
//

import SwiftUI

struct SignInView: View {
    @EnvironmentObject var authManager: AuthManager
    @State var id: String = ""
    @State var password: String = ""
    var body: some View {
        VStack{
            Text("해 밀")
                .bold()
                .font(.system(size: 50))
            
            HStack {
                Text("아이디")
                TextField("아이디 입력", text: $id)
            }
            .padding(.horizontal, 30)
            .padding(.vertical, 5)
            
            HStack {
                Text("비밀번호")
                SecureField("비밀번호 입력", text: $password)
            }
            .padding(.horizontal, 30)
            .padding(.vertical, 5)
            
            Button("로그인") {
                Task {
                    try await authManager.login(id: id, password: password)
                }
            }.font(.system(size:25))
                .padding(.top, 20)
        }
    }
}

#Preview {
    SignInView()
}
