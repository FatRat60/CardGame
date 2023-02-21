//
//  StoreView.swift
//  CardGame
//
//  Created by Kyle Hultgren on 10/16/22.
//

import SwiftUI
import Alamofire
import SwiftyJSON

struct StoreView: View {
    @State var storeItems: [CardSelect] = []
    @State private var didLoad: Bool = false
    @State private var pressed: Bool = false
    @Binding var user: User?
    var body: some View {
        ZStack{
            Image("mainMenuBackground")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            VStack{
                Text("Store")
                    .font(.system(size: 28, weight: .bold))
                if storeItems.count > 0 {
                ForEach(storeItems, id: \.id){
                    card in
                    VStack{
                        CardSelectCard(cardSel: card)
                        if (user != nil && user!.decks.count < 2){
                            Button(action: {user!.decks.append(card)}, label: {
                                Text("Buy: $\(card.price)")
                                .padding()
                                .font(.title)
                                .foregroundColor(.black)
                                .background(Color.purple)
                                .cornerRadius(30)
                        })
                    }
                        else {
                            Text("Out of Stock")
                        }
                    }
                }
                }
                else {
                    Text("No Items :/")
                }
                Button(action: {pressed = true}, label: {
                    Text("Return")
                        .padding()
                        .font(.title)
                        .foregroundColor(.black)
                        .background(Color.purple)
                        .cornerRadius(30)
                })
            }
        }
        .onAppear(perform: {if !didLoad {
            AF.request("http://localhost:6969/store", method: .post, parameters: ["items":["Anime"]], encoder: JSONParameterEncoder.default).responseJSON {
                (response) in
                switch response.response?.statusCode {
                case let code?:
                    switch code {
                    // if sucess try to parse User
                    case 200:
                        do {
                            storeItems = []
                            let json = JSON(response.value!)
                            let saleJSON :Array<JSON> = json.arrayValue
                            for item in saleJSON {
                                storeItems.append(CardSelect(id: 2, image: item["display"].stringValue, name: item["name"].stringValue, price: item["price"].intValue))
                            }
                            didLoad = true
                        }
                    default:
                        print("Could not get user")
                    }
                case .none:
                    print("Request failed")
                }
            }
        }})
        .navigate(to: MainMenuView(user: user), when: $pressed)
    }
}

struct StoreView_Previews: PreviewProvider {
    @State static private var user: User? = nil
    
    static var previews: some View {
        StoreView(user: $user)
    }
}
