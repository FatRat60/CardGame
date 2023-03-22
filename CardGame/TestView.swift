//
//  TestView.swift
//  CardGame
//
//  Created by Kyle Hultgren on 3/21/23.
//

import SwiftUI

struct TestView: View {
    @State private var Donavigate : Bool = false
    
    var body: some View {
        ZStack{
            Button(action: {Donavigate = true}, label: {
                Text("Singleplayer")
                    .padding()
                    .font(.title)
                    .foregroundColor(.black)
                    .background(Color.purple)
                    .cornerRadius(30)
            })
        }
        .navigate(to: MainMenuView(), when: $Donavigate)
        
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
