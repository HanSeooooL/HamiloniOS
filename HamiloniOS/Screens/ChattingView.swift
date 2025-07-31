//
//  ChattingView.swift
//  HamiloniOS
//
//  Created by 한설 on 7/31/25.
//

import SwiftUI

struct ChattingView: View {
    
    @EnvironmentObject var authManager: AuthManager
    @StateObject var chatViewModel = ChatViewModel()
    
    @State private var inputmessage: String = ""

    
    var body: some View {
        VStack {
            Text("채팅 화면")
            ChattingContainerView(chattings: chatViewModel.chatlist)
                .task {
                    do {
                        try await chatViewModel.initMessageHistory()
                    } catch {
                        print("Error: MessageHistory initialize")
                    }
                }
            
            Spacer()
            
            HStack {
                TextField("메세지를 입력하세요", text: $inputmessage)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button(action: {
                    // 메세지 전송 로직
                    Task {
                        do {
                            let tmpmessage = inputmessage
                            inputmessage = ""
                            try await chatViewModel.sendChat(chat: Chat(author: authManager.user!.id, content: tmpmessage))
                        } catch {
                            print("Error!")
                        }
                    }
                }, label: {
                    Text("전송")
                })
            }
                
        }
        .padding()
    }
}

struct ChattingContainerView: View {
    var chattings: Array<ChatVO>
    var body: some View {
        ScrollView(content: {
            ForEach(chattings, id: \.self) { chatting in
                HStack(content: {
                    if chatting.author == "AI" {
                        AIChatView(vo:chatting)
                    } else {
                        MyChatView(vo:chatting)
                    }
                })
                
            }
        })
    }
}

protocol ChatView: View {
    var vo: ChatVO { get set }
}

struct MyChatView: ChatView {
    var vo: ChatVO
    
    var body: some View {
        HStack {
            Spacer()
            
            Text(vo.content)
        }.padding(.vertical, 5)
    }
}

struct AIChatView: ChatView {
    var vo: ChatVO
    
    var body:some View {
        HStack {
            Text(vo.content)
            
            Spacer()
        }.padding(.vertical, 5)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ChattingView()
    }
}
