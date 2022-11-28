//
//  SinglePlayerView2.swift
//  CardGame
//
//  Created by Kyle Hultgren on 11/9/22.
//

import SwiftUI

struct SinglePlayerView2: View {
    var selDeck: String
    var numPlayers: Int
    var user :User
    @State private var player :Player = Player()
    @State private var dealer :Player = Player()
    @State private var deck = [Card]()
    @State private var pressStart: Bool = false
    @State private var lost: Bool = false
    @State private var won: Bool = false
    @State private var gamesPlayed: Int = 0
    @State private var initialMoney = 0
    @State private var gameEnd: Bool = false
    
    var start: some View {
        VStack{
        Button(action: {
                player = Player(name: user.displayName, money: user.money)
                initialMoney = user.money
                for suit in CardSuite.allCases {
                    for i in 1...13 {
                        let card: Card = Card(cardSuite: suit, cardNum: String(i), deckType: selDeck)
                        deck.append(card)
                    }
                }
                deck.shuffle()
                deck.shuffle()
                player.hand.append(deck.randomElement()!)
                player.hand.append(deck.randomElement()!)
                dealer.hand.append(deck.randomElement()!)
                dealer.hand.append(deck.randomElement()!)
                pressStart = true}, label: {
            Text("Start")
                .padding()
                .font(.title)
                .foregroundColor(.black)
                .background(Color.purple)
                .cornerRadius(30)
        })
        }
    }
    
    var game: some View {
        ZStack{
            VStack{
            HStack{
                Spacer()
                Text(player.name)
                    .padding()
                    .foregroundColor(.black)
                    .background(Color.pink)
                    .cornerRadius(10)
                Text("Money: $" + String(player.money))
                    .padding()
                    .foregroundColor(.black)
                    .background(Color.pink)
                    .cornerRadius(10)
            Spacer()
            }
                HandView(owner: dealer.name, hand: dealer.hand)
                HandView(owner: player.name, hand: player.hand)
                HStack{
                    Button(action: {player.hand.append(deck.randomElement()!)
                            let currSum = player.sumHand()
                            print(currSum)
                        if (currSum > 21){
                            print("Lost")
                        lost = true
                    }
                        else if (currSum == 21){
                            won = true
                        }}, label: {
                Text("Hit Me")
                    .padding()
                    .foregroundColor(.black)
                    .background(Color.purple)
                    .cornerRadius(30)
            })
                    Button(action: {let total = player.sumHand()
                        var DealerTotal = dealer.sumHand()
                        while (DealerTotal < 16){
                            dealer.hand.append(deck.randomElement()!)
                            DealerTotal = dealer.sumHand()
                        }
                        if (DealerTotal > 21 || total > DealerTotal){won = true}
                        else { lost = true}
                    }, label: {
                        Text("Stay")
                            .padding()
                            .foregroundColor(.black)
                            .background(Color.purple)
                            .cornerRadius(30)
                    })
                }
            }
        }
        .alert(isPresented: $lost, content: {
            Alert(title: Text("YOU LOST"), message: Text("play again?"),
                  dismissButton: .cancel({lost = false}))
        })
        .alert(isPresented: $won, content: {
            Alert(title: Text("YOU WON"), message: Text("play again?"),
                  primaryButton: .default(Text("Yes"), action: {gamesPlayed += 1
                        player.hand = [Card]()
                        dealer.hand = [Card]()
                        player.hand.append(deck.randomElement()!)
                        player.hand.append(deck.randomElement()!)
                        dealer.hand.append(deck.randomElement()!)
                        dealer.hand.append(deck.randomElement()!)
                        won = false}),
                  secondaryButton: .default(Text("Stop"), action: {gamesPlayed += 1
                        gameEnd = true}))
        })
    }
    
    var body: some View {
        ZStack{
            Image("mainMenuBackground")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            if (!pressStart) {start}
            else { game }
        }
        .navigate(to: GameResultsView(user: user, gamesPlayed: gamesPlayed, moneyEarned: player.money - initialMoney), when: $gameEnd)
    }
}


struct SinglePlayerView2_Previews: PreviewProvider {
    static var previews: some View {
        SinglePlayerView2(selDeck: "Classic", numPlayers: 4, user: User(username: "Garsh", displayName: "Garsh", money: 102093))
    }
}
