//
//  StoreView.swift
//  CardGame
//
//  Created by Kyle Hultgren on 10/16/22.
//

import SwiftUI
import Alamofire
import SwiftyJSON
import StripePaymentSheet

struct payView: View {
    @Binding var user: User?
    var clientSecret: String
    var ephKey: String
    var cust: String
    
    @State private var sheet: PaymentSheet? = nil
    @State private var pay: Bool = false
    
    var body: some View {
        ZStack{
            if (sheet != nil){
                paymentSheet(isPresented: $pay, paymentSheet: sheet!, onCompletion: {(paymentResult) in
                    switch paymentResult {
                    case .completed:
                        print("paymentCompleted")
                    case .canceled:
                        print("Payment canceled!")
                    case .failed:
                        print("payment failed")
                    }})
            }
            else{
                Text("Loading...")
            }
        }
        .onAppear(perform: {
            var config = PaymentSheet.Configuration()
            config.merchantDisplayName = "Fat Rat, Inc"
            config.customer = .init(id: cust, ephemeralKeySecret: ephKey)
            
            DispatchQueue.main.async {
                sheet = PaymentSheet(paymentIntentClientSecret: clientSecret, configuration: config)
            }
            
            pay = true
            if (sheet != nil){
                print("Finished")
            }
        })
    }
}

struct StoreView: View {
    @State var storeItems: [CardSelect] = []
    @State private var didLoad: Bool = false
    @State private var didBuy: Bool = false
    @State private var pressed: Bool = false
    @Binding var user: User?
    @State private var clientSecret: String = ""
    @State private var custId: String = ""
    @State private var ephKey: String = ""
    @State private var boughtItem: CardSelect? = nil
    
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
                            Button(action: {AF.request("http://localhost:6969/payment", method: .post, parameters: ["items": [card.name]], encoder: JSONParameterEncoder.default).responseJSON {
                                (response) in
                                switch response.response?.statusCode {
                                case let code?:
                                    switch code {
                                    case 200:
                                        do {
                                            let json = JSON(response.value!)
                                            clientSecret = json["clientSecret"].stringValue
                                            custId = json["customer"].stringValue
                                            ephKey = json["ephemeralKey"].stringValue
                                            didBuy = true
                                        }
                                    default:
                                        print("failed")
                                    }
                                case .none:
                                    print("failed")
                                }
                            }}, label: {
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
        .onAppear(perform: {StripeAPI.defaultPublishableKey = "pk_live_51MZiLnLnhkBEjmx59kHkPeJPeTkqJDBnAt1JcltDpkkh9LWgEeCVLecaUw4kqJrzBSo0rCSjfRYoOrTKqZaDXktx00JeCeTMVQ"
            if !didLoad {
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
        .onDisappear(perform: {
            
        })
        .navigate(to: MainMenuView(user: user), when: $pressed)
        .popover(isPresented: $didBuy, content: {payView(user: $user, clientSecret: clientSecret, ephKey: ephKey, cust: custId)})
    }
}

struct StoreView_Previews: PreviewProvider {
    @State static private var user: User? = nil
    
    static var previews: some View {
        StoreView(user: $user)
    }
}
