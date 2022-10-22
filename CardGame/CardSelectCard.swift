//
//  CardSelectCard.swift
//  CardGame
//
//  Created by Kyle Hultgren on 10/21/22.
//

import SwiftUI

struct CardSelectCard: View {
    var cardSel: CardSelect
    
    var body: some View {
        ZStack{
            Capsule()
                .fill(Color.purple)
                .frame(width: 120, height: 175)
        VStack {
            Image(cardSel.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 90, height: 100)
            VStack{
                Text(cardSel.name)
                    .font(.headline)
            }
        }
    }
    }
}

struct CardSelectCard_Previews: PreviewProvider {
    static var previews: some View {
        CardSelectCard(cardSel: CardSelectList[0])
        CardSelectCard(cardSel: CardSelectList[1])
    }
}
