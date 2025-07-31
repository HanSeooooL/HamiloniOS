//
//  MainView.swift
//  HamiloniOS
//
//  Created by 한설 on 7/31/25.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            ChattingView()
                .tabItem {
                    Text("Chat")
                }
            
            GraphView()
                .tabItem {
                    Text("Graph")
                }
            
            OptionMenuView()
                .tabItem {
                    Text("Menu")
                }
            
        }
    }
}

#Preview {
    MainView()
}
