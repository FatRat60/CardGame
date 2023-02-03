//
//  LeaderBoardView.swift
//  CardGame
//
//  Created by Kyle Hultgren on 1/29/23.
//

import SwiftUI
import Alamofire

struct LeaderBoardView: View {
    
    var body: some View {
        ZStack{
            Text("Garsh")
        }
        .onAppear(perform: {
            AF.request("http://localhost:6969/users").responseJSON {
                (response) in debugPrint(response)
            }
        })
    }
}

struct LeaderBoardView_Previews: PreviewProvider {
    static var previews: some View {
        LeaderBoardView()
    }
}
