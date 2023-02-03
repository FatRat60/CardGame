//
//  GameResultsView.swift
//  CardGame
//
//  Created by Kyle Hultgren on 11/28/22.
//

import SwiftUI
import Alamofire

struct GameResultsView: View {
    @Binding var user: User?
    var gamesPlayed: Int
    var moneyEarned: Int
    @State private var toMain: Bool = false
    
    var body: some View {
        ZStack{
            VStack{
                if (moneyEarned >= 0){
                    Text("Congratulations!!")
                        .font(.system(size: 28, weight: .bold))
                    Text("\(user?.displayName ?? "defaultUser") won a whopping $\(moneyEarned) over \(gamesPlayed) games.")
                    Text("Fucking sick as 'ell, mate!")
                }
                else{
                    Text("Ruh Roh...")
                        .font(.system(size: 28, weight: .bold))
                    Text(user?.displayName ?? "defaultUser" + " lost a whopping $\(-moneyEarned) over \(gamesPlayed) games.")
                    Text("Better luck next time!")
                }
                Spacer()
                Button(action: {if user != nil {user!.gamesPlayed += gamesPlayed
                        user!.money += moneyEarned
                    AF.request("http://localhost:6969/updateUser", method: .post, parameters: ["username":user!.username, "displayName":user!.displayName, "money":String(user!.money), "wins":String(user!.wins), "gamesPlayed":String(user!.gamesPlayed)], encoder: JSONParameterEncoder.default).response {
                        response in debugPrint(response)
                    }}
                        toMain = true}, label: {
                    Text("Main Menu")
                        .padding()
                        .font(.title)
                        .foregroundColor(.white)
                        .background(Color.pink)
                        .cornerRadius(30)
                })
            }
        }
        .navigate(to: MainMenuView(user: user), when: $toMain)
    }
}

struct GameResultsView_Previews: PreviewProvider {
    @State static var user: User? = nil
    
    static var previews: some View {
        GameResultsView(user: $user, gamesPlayed: 12, moneyEarned: -45000)
    }
}
