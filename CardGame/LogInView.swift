//
//  LogInView.swift
//  CardGame
//
//  Created by Kyle Hultgren on 1/23/23.
//

import SwiftUI
import Alamofire

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
                    TextField("Required", text: $password)
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
                                if let data = response.value as? [String: Any] {
                                    user = User(username: data["username"] as! String, displayName: data["displayName"] as! String, money: data["money"] as! Int, wins: data["wins"] as! Int, gamesPlayed: data["gamesPlayed"] as! Int)
                                    keepOpen = false
                                }
                                else{
                                    invalid = true
                                }
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

typealias gotUser = (inout Bool, inout Bool, User?) -> ()

func makeLogInCall(username: String, password: String, user: inout User?, keepOpen: inout Bool, invalid: inout Bool,  completed: gotUser) -> Void {
    var DataUser: User? = nil
    // Make the login call
    AF.request("http://localhost:6969/login", method: .post, parameters: ["username":username, "password":password], encoder: JSONParameterEncoder.default).responseJSON { (response) in
        // Check the status code of response
        switch response.response?.statusCode {
        case let code?:
            print(code)
            switch code {
            // if sucess try to parse User
            case 200:
                do {
                    if let data = response.value as? [String: Any] {
                        DataUser = User(username: data["username"] as! String, displayName: data["displayName"] as! String, money: data["money"] as! Int, wins: data["wins"] as! Int, gamesPlayed: data["gamesPlayed"] as! Int)
                    }
                }
            default:
                print("Could not get user")
            }
        case .none:
            print("Request failed")
        }
    }
    user = DataUser
    print("request over")
    // After request call closure
    completed(&keepOpen, &invalid, user)
}

func checkUser(keepOpen: inout Bool, invalid: inout Bool, user: User?) -> Void {
    print("checking user")
    // If user is found && valid password, return to main menu
    if user != nil {
        keepOpen = false
    }
    // enable invalid credentials pop up
    else {
        invalid = true
    }
}

struct LogInView_Previews: PreviewProvider {
    @State static var test: User? = nil
    @State static var open: Bool = true
    
    static var previews: some View {
        LogInView(user: $test, keepOpen: $open)
    }
}
