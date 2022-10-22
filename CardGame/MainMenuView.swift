//
//  MainMenuView.swift
//  CardGame
//
//  Created by Kyle Hultgren on 10/9/22.
//

import SwiftUI

struct MainMenuView: View {
    @State private var nextView: Int = 0
    @State private var isAlert: Bool = false
    
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
                Divider()
                HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: -10){
                    Image("kokomi")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    Image("shinoa")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    Image("keqing")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                }
                Button(action: {nextView = 1}, label: {
                    Text("Singleplayer")
                        .padding()
                        .font(.title)
                        .foregroundColor(.black)
                        .background(Color.purple)
                        .cornerRadius(30)
                })
                Button(action: {isAlert = true}, label: {
                    Text("Multiplayer")
                        .padding()
                        .font(.title)
                        .foregroundColor(.black)
                        .background(Color.purple)
                        .cornerRadius(30)
                })
                Button(action: {nextView = 3}, label: {
                    Text("Store")
                        .padding()
                        .font(.title)
                        .foregroundColor(.black)
                        .background(Color.purple)
                        .cornerRadius(30)
                })
                Button(action: {nextView = 4}, label: {
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
        .navigate(to: PreGameView(), when: Binding<Bool>(get: {nextView == 1}, set: {_ in}))
        .navigate(to: MainMenuView(), when: Binding<Bool>(get: {nextView == 2}, set: {_ in}))
        .navigate(to: StoreView(), when: Binding<Bool>(get: {nextView == 3}, set: {_ in}))
        .navigate(to: OptionView(), when: Binding<Bool>(get: {nextView == 4}, set: {_ in}))
        .alert(isPresented: $isAlert, content: {
            Alert(title: Text("STOP"), message: Text("Feature Not Yet Implemented"), dismissButton: .cancel({isAlert = false}))
        })
    }
}

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView()
    }
}
