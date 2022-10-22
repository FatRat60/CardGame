//
//  PreGameView.swift
//  CardGame
//
//  Created by Kyle Hultgren on 10/15/22.
//

import SwiftUI

struct PreGameView: View {
    @State private var pressed: Bool = false
    @State var selDeck: String = ""
    @State var isAlert: Bool = false
    
    var body: some View {
        ZStack{
            Image("mainMenuBackground")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            VStack{
                Spacer()
                Text("Game Options")
                    .font(.system(size: 28, weight: .bold))
                Divider()
                Spacer()
                Text("Decks")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                Divider()
                HStack(alignment: .center){
                        ForEach(CardSelectList, id: \.id){
                            card in
                            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: CGFloat(-20)){
                            CardSelectCard(cardSel: card)
                                Button(action: {self.selDeck = card.name}, label: {
                                Text("Use")
                            }).disabled(!card.canPick)
                                .padding(/*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                                .font(.custom("headline", size: CGFloat(15)))
                                .foregroundColor(.black)
                                .background(Color.green)
                                .cornerRadius(30)
                            }
                        }
                    }
                Spacer()
                Button(action: {if !self.selDeck.isEmpty {
                    pressed = true
                } else {
                    isAlert = true
                }}, label: {
                    Text("Play")
                        .padding()
                        .font(.title)
                        .foregroundColor(.black)
                        .background(Color.purple)
                        .cornerRadius(30)
                })
                Spacer()
            }
        }
        .navigate(to: SinglePlayerView(selDeck: selDeck), when: $pressed)
        .alert(isPresented: $isAlert, content: {
            Alert(title: Text("STOP"), message: Text("Please select a deck to continue"),
                  dismissButton: .cancel(Text("Ok"), action: {isAlert = false}))
            })
    }
}

struct PreGameView_Previews: PreviewProvider {
    static var previews: some View {
        PreGameView()
    }
}
