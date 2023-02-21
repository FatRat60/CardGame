//
//  SignUpView.swift
//  CardGame
//
//  Created by Kyle Hultgren on 1/27/23.
//

import SwiftUI
import Alamofire
import SwiftyJSON

struct SignUpView: View {
    @Binding var user: User?
    @Binding var keepOpen: Bool
    @State private var invalid: Bool = false
    @State private var username: String = ""
    @State private var password: String = ""
    
    var body: some View {
        ZStack{
            Form{
                Text("Sign Up")
                    .font(.title)
                    .bold()
                HStack{
                    Text("Username")
                    TextField("Required", text: $username)
                        .disableAutocorrection(true)
                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                }
                HStack{
                    Text("Password")
                    TextField("Required", text: $password)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                }
                Button(action: {// Make the signup call
                    let image = UIImage(named: "defaultPfp")
                    AF.request("http://localhost:6969/signup", method: .post, parameters: ["username":username, "password":password, "profile":image!.pngData()!.base64EncodedString()], encoder: JSONParameterEncoder.default).responseJSON { (response) in
                        // Check the status code of response
                        switch response.response?.statusCode {
                        case let code?:
                            print(code)
                            switch code {
                            // if sucess try to parse User
                            case 201:
                                do {
                                    let json = JSON(response.value!)
                                    let deckJson :Array<JSON> = json["decks"].arrayValue
                                    var decks :[CardSelect] = []
                                    for deck in deckJson {
                                        decks.append(CardSelect(id: deck["id"].intValue, image: deck["image"].stringValue, name: deck["name"].stringValue, price: 1))
                                    }
                                    user = User(username: json["username"].stringValue, displayName: json["displayName"].stringValue, profile: json["profile"].stringValue, money: json["money"].intValue, wins: json["wins"].intValue, gamesPlayed: json["gamesPlayed"].intValue, decks: decks)
                                        keepOpen = false
                                }
                            default:
                                print("Could not get user")
                                invalid = true
                            }
                        case .none:
                            print("Request failed")
                            invalid = true
                        }
                    }
                }, label: {
                    Text("Submit")
                        .padding()
                        .font(.body)
                        .foregroundColor(.black)
                        .background(Color.purple)
                        .cornerRadius(30)
                })
            }
        }
        .alert(isPresented: $invalid, content: {
            Alert(title: Text("STOP"), message: Text("Username \"\(username)\" already Taken"), dismissButton: .cancel({username = ""; invalid = false}))
        })
    }
}

func signUpCall(username: String, password: String) -> Void {
    // Make the signup call
    AF.request("http://localhost:6969/signup", method: .post, parameters: ["username":username, "password":password], encoder: JSONParameterEncoder.default).responseJSON { (response) in
        // Check the status code of response
        switch response.response?.statusCode {
        case let code?:
            print(code)
            switch code {
            // if sucess try to parse User
            case 201:
                do {
                    
                }
            default:
                print("Could not get user")
            }
        case .none:
            print("Request failed")
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    @State static private var user: User? = nil
    @State static private var keepOpen: Bool = true
    
    static var previews: some View {
        SignUpView(user: $user, keepOpen: $keepOpen)
    }
}
