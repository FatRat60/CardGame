//
//  HandView.swift
//  CardGame
//
//  Created by Kyle Hultgren on 11/10/22.
//

import SwiftUI

struct HandView: View {
    var owner: String
    var hand: [Card]
    var body: some View {
        VStack{
            Text(owner + "'s Hand")
            HStack{
                ForEach(hand, id: \.id){
                    card in
                    Image(card.currText)
                        .resizable()
                        .frame(width: 75, height: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                }
            }
        }
    }
}

struct HandView_Previews: PreviewProvider {
    static var previews: some View {
        HandView(owner: "FatRat60", hand: [Card(cardSuite: CardSuite.spades, cardNum: "4", deckType: "Classic")])
    }
}
