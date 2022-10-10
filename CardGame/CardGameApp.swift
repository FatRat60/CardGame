//
//  CardGameApp.swift
//  CardGame
//
//  Created by Kyle Hultgren on 10/6/22.
//

import SwiftUI

@main
struct CardGameApp: App {
    var body: some Scene {
        WindowGroup {
            MainMenuView()
        }
    }
}

extension View {
    func navigate<NewView: View>(to view: NewView, when binding: Binding<Bool>) -> some View {
        NavigationView {
            ZStack {
                self
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
                
                NavigationLink(
                    destination: view
                        .navigationBarTitle("")
                        .navigationBarHidden(true),
                    isActive: binding
                    ) {
                        EmptyView()
                }
            }
        }
    }
}
