//
//  ContentView.swift
//  HamiloniOS
//
//  Created by 한설 on 2025/07/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            MyChatView(vo: ChatVO(author: "test1", content: "hello", timestamp: "2024-05-24 11:30"))
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
            Text(vo.content)
        }
    }
}

struct AIChatView: ChatView {
    var vo: ChatVO
    
    var body:some View {
        HStack {
            Text(vo.content)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
