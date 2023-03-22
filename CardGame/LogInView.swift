//
//  LogInView.swift
//  CardGame
//
//  Created by Kyle Hultgren on 1/23/23.
//

import SwiftUI
import Alamofire
import SwiftyJSON

struct LogInView: View {
    @Binding var user: User?
    @Binding var keepOpen: Bool
    @State private var invalid: Bool = false
    @State private var toRegister: Bool = false
    @State private var username: String = ""
    @State private var password: String = ""
    
    var body: some View {
        ZStack{
            Form{
                Text("Log In")
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
                    SecureField("Required", text: $password)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                }
                Button(action:{AF.request("http://localhost:6969/login", method: .post, parameters: ["username":username, "password":password], encoder: JSONParameterEncoder.default).responseJSON { (response) in
                    // Check the status code of response
                    switch response.response?.statusCode {
                    case let code?:
                        print(code)
                        switch code {
                        // if sucess try to parse User
                        case 200:
                            do {
                                let json = JSON(response.value!)
                                let deckJson = json["decks"].arrayValue
                                var decks :[CardSelect] = []
                                for deck in deckJson {
                                    decks.append(CardSelect(id: deck["id"].intValue, image: deck["image"].stringValue, name: deck["name"].stringValue, price: 1))
                                }
                                user = User(username: json["username"].stringValue, displayName: json["displayName"].stringValue, profile: json["profile"].stringValue, money: json["money"].intValue, wins: json["wins"].intValue, gamesPlayed: json["gamesPlayed"].intValue,
                                                decks: decks)
                                    keepOpen = false
                            }
                        default:
                            invalid = true
                            print("Could not get user")
                        }
                    case .none:
                        print("Request failed")
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
                Divider()
                Text("Dont't have an account? Sign up!")
                    Button(action: { toRegister = true
                    }, label: {
                        Text("Register")
                            .padding()
                            .font(.body)
                            .foregroundColor(.black)
                            .background(Color.purple)
                            .cornerRadius(30)
                    })
            }
            Spacer()
        }
        .navigate(to: SignUpView(user: $user, keepOpen: $keepOpen), when: $toRegister)
        .alert(isPresented: $invalid, content: {
            Alert(title: Text("STOP"), message: Text("Invalid Login Credentials"), dismissButton: .cancel({invalid = false}))
        })
    }
}

struct LogInView_Previews: PreviewProvider {
    @State static var test: User? = nil
    @State static var open: Bool = true
    
    static var previews: some View {
        LogInView(user: $test, keepOpen: $open)
    }
}
