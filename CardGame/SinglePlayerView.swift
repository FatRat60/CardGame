//
//  SinglePlayerView.swift
//  CardGame
//
//  Created by Kyle Hultgren on 10/22/22.
//

import SwiftUI

struct SinglePlayerView: View {
    var selDeck: String
    var numPlayers: Int
    
    var body: some View {
        ZStack{
            Image("mainMenuBackground")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            Text(selDeck)
            Text(String(numPlayers))
        }
    }
}

struct SinglePlayerView_Previews: PreviewProvider {
    static var previews: some View {
        SinglePlayerView(selDeck: "Classic", numPlayers: 4)
    }
}
