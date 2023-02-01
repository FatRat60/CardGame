//
//  OptionView.swift
//  CardGame
//
//  Created by Kyle Hultgren on 10/9/22.
//

import SwiftUI
import Alamofire

struct editView: View {
    @State private var displayName: String = ""
    @State private var isAlert: Bool = false
    @Binding var state: Bool
    @Binding var user: User?
    
    var body: some View {
        Form{
            VStack{
                HStack{
                    Text("Display Name")
                    TextField("Required", text: $displayName)
                        .disableAutocorrection(true)
                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                }
                Button(action: {AF.request("http://localhost:6969/updateUser", method: .post, parameters: ["username":user!.username, "displayName":displayName, "money":String(user!.money), "wins":String(user!.wins), "gamesPlayed":String(user!.gamesPlayed)], encoder: JSONParameterEncoder.default).response { (response) in
                    // Check the status code of response
                    switch response.response?.statusCode {
                    case let code?:
                        print(code)
                        switch code {
                        // if sucess try to parse User
                        case 200:
                            do {
                                user!.displayName = displayName
                                
                            }
                        default:
                            print("Could not get user")
                        }
                    case .none:
                        print("Request failed")
                    }
                    state = false
                }}, label: {
                    Text("Save")
                        .padding()
                        .font(.footnote)
                        .foregroundColor(.black)
                        .background(Color.purple)
                        .cornerRadius(15)
                })
            }
        }
        .alert(isPresented: $isAlert, content: {
            Alert(title: Text("Error"), message: Text("Could not update name"), dismissButton: .cancel({isAlert = false}))
        })
    }
}

struct OptionView: View {
    @State private var pressed: Bool = false
    @State private var changeName: Bool = false
    @Binding var user: User?
    
    var body: some View {
        ZStack{
            Image("mainMenuBackground")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 5){
                Spacer()
                Text(user!.username + "'s Profile")
                    .font(.system(size: 28, weight: .bold))
                Divider()
                Image("defaultPfp")
                    .resizable()
                    .frame(width: 200, height: 150, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                Button(action: {}, label: {
                    Text("Change Profile Pic")
                        .padding()
                        .font(.footnote)
                        .foregroundColor(.black)
                        .background(Color.purple)
                        .cornerRadius(15)
                })
                VStack{
                    Text("Display Name: \(user!.displayName)")
                    Text("")
                    Button(action: {changeName = true}, label: {
                        Text("Edit Profile")
                            .padding()
                            .font(.subheadline)
                            .foregroundColor(.black)
                            .background(Color.purple)
                            .cornerRadius(30)
                    })
                }
                Button(action: {pressed = true}, label: {
                    Text("Save")
                        .padding()
                        .font(.title)
                        .foregroundColor(.black)
                        .background(Color.purple)
                        .cornerRadius(30)
                })
                Spacer()
            }
        }
        .navigate(to: MainMenuView(), when: $pressed)
        .popover(isPresented: $changeName, arrowEdge: .top, content: {
            editView(state: $changeName, user: $user)
        })
    }
}

struct OptionView_Previews: PreviewProvider {
    @State static var user: User? = User(username: "FatRat60", displayName: "YeaBaby")
    
    static var previews: some View {
        OptionView(user: $user)
    }
}
