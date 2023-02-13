//
//  PreGameView.swift
//  CardGame
//
//  Created by Kyle Hultgren on 10/15/22.
//

import SwiftUI

struct TopView: View {
    var body: some View {
        Text("Game Options")
            .font(.system(size: 28, weight: .bold))
        Divider()
    }
}

struct MidView: View {
    @Binding var selDeck: String
    var decks :[CardSelect]
    
    var body: some View {
        Text("Decks")
            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
        Divider()
        HStack(alignment: .center){
                ForEach(decks, id: \.id){
                    card in
                    VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: CGFloat(-20)){
                    CardSelectCard(cardSel: card)
                        Button(action: {selDeck = card.name}, label: {
                        Text("Use")
                    })
                        .padding(/*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                        .font(.custom("headline", size: CGFloat(15)))
                        .foregroundColor(.black)
                        .background(Color.green)
                        .cornerRadius(30)
                    }
                }
            }
        Text("Selected Deck: \(selDeck.isEmpty ? "None" : selDeck)")
    }
}

struct BotView: View {
    @Binding var numPlayers: Int
    
    var body: some View {
        Text("Number of Players")
            .font(.title)
        Divider()
        HStack {
            Button{
                    numPlayers -= 1
            } label: {
                Image("leftArrow")
                    .resizable()
                    .frame(width: 20, height: 20)
            }.disabled(numPlayers == 2)
            Text(String(numPlayers))
            Button{
                    numPlayers += 1
            } label: {
                Image("rightArrow")
                    .resizable()
                    .frame(width: 20, height: 20)
            }.disabled(numPlayers == 4)
        }
    }
}

struct PreGameView: View {
    @State private var pressed: Bool = false
    @State private var isAlert: Bool = false
    @State var selDeck: String = ""
    @State var numPlayers: Int = 2
    @Binding var user: User?
    
    var body: some View {
        ZStack{
            Image("mainMenuBackground")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            VStack{
                Spacer()
                Spacer()
                TopView()
                MidView(selDeck: $selDeck, decks: user?.decks ?? [CardSelect(id: 1, image: "defaultCard", name: "Classic")])
                Spacer()
                BotView(numPlayers: $numPlayers)
                Spacer()
                Button(action: {if !selDeck.isEmpty {
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
        .navigate(to: SinglePlayerView2(selDeck: selDeck, numPlayers: numPlayers, user: $user), when: $pressed)
        .alert(isPresented: $isAlert, content: {
            Alert(title: Text("STOP"), message: Text("Please select a deck to continue"),
                  dismissButton: .cancel(Text("Ok"), action: {isAlert = false
                  }))
            })
    }
}


struct PreGameView_Previews: PreviewProvider {
    @State static var user: User? = nil
    
    static var previews: some View {
        PreGameView(user: $user)
    }
}
