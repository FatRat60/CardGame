//
//  MainMenuView.swift
//  CardGame
//
//  Created by Kyle Hultgren on 10/9/22.
//

import SwiftUI

struct MainMenuView: View {
    var body: some View {
        ZStack{
            Image("mainMenuBackground")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            VStack(alignment: .center, spacing: 5){
                Spacer()
                Text("FatRat60's Card Game")
                    .font(.system(size: 28, weight: .bold))
                Spacer()
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text("Singleplayer")
                        .padding()
                        .font(.title)
                        .foregroundColor(.black)
                        .background(Color.purple)
                        .cornerRadius(30)
                })
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text("Multiplayer")
                        .padding()
                        .font(.title)
                        .foregroundColor(.black)
                        .background(Color.purple)
                        .cornerRadius(30)
                })
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text("Store")
                        .padding()
                        .font(.title)
                        .foregroundColor(.black)
                        .background(Color.purple)
                        .cornerRadius(30)
                })
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text("Options")
                        .padding()
                        .font(.title)
                        .foregroundColor(.black)
                        .background(Color.purple)
                        .cornerRadius(30)
                })
                Spacer()
            }
        }
    }
}

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView()
    }
}
