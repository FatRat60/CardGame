//
//  MainMenuView.swift
//  CardGame
//
//  Created by Kyle Hultgren on 10/9/22.
//

import SwiftUI
import Alamofire
import SwiftyJSON

struct buttonView: View {
    @Binding var nextView: Int
    @Binding var isAlert: Bool
    @Binding var user: User?
    
    var body: some View {
        Button(action: {nextView = 1}, label: {
            Text("Singleplayer")
                .padding()
                .font(.title)
                .foregroundColor(.black)
                .background(Color.purple)
                .cornerRadius(30)
        })
        Button(action: {if (user != nil){
            nextView = 2
        }
            else{
                isAlert = true
            }
        }, label: {
            Text("Multiplayer")
                .padding()
                .font(.title)
                .foregroundColor(.black)
                .background(Color.purple)
                .cornerRadius(30)
        })
        Button(action: {nextView = 3}, label: {
            Text("Store")
                .padding()
                .font(.title)
                .foregroundColor(.black)
                .background(Color.purple)
                .cornerRadius(30)
        })
        if user != nil{
        Button(action: {nextView = 4}, label: {
            Text("Profile")
                .padding()
                .font(.title)
                .foregroundColor(.black)
                .background(Color.purple)
                .cornerRadius(30)
        })}
    }
}

struct MainMenuView: View {
    @State private var isAlert: Bool = false
    @State var user: User?
    @State private var nextView: Int = 0
    @State private var logView: Bool = false
    
    var body: some View {
        ZStack{
            Image("mainMenuBackground")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            VStack(alignment: .center, spacing: 5){
                Spacer()
                if user == nil {Button(action: {logView=true}, label: {
                    Text("Login")
                        .padding()
                        .font(.caption)
                        .foregroundColor(.black)
                        .background(Color.purple)
                        .cornerRadius(30)
                })}
                else{
                    HStack{
                        Text("Welcome, " + user!.displayName)
                        Button(action: {user = nil}, label: {
                            Text("Sign Out")
                                .padding()
                                .font(.caption)
                                .foregroundColor(.black)
                                .background(Color.purple)
                                .cornerRadius(30)
                        })
                    }
                }
                Text("FatRat60's Card Game")
                    .font(.system(size: 28, weight: .bold))
                Divider()
                HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: -10){
                    Image("kokomi")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    Image("shinoa")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    Image("keqing")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                }
                buttonView(nextView: $nextView, isAlert: $isAlert, user: $user)
                Spacer()
            }
        }
        .navigate(to: PreGameView(user: $user), when: Binding<Bool>(get: {nextView == 1}, set: {_ in}))
        .navigate(to: RoomSelectView(), when: Binding<Bool>(get: {nextView == 2}, set: {_ in}))
        .navigate(to: StoreView(user: $user), when: Binding<Bool>(get: {nextView == 3}, set: {_ in}))
        .navigate(to: OptionView(user: $user), when: Binding<Bool>(get: {nextView == 4}, set: {_ in}))
        .navigate(to: TestView(), when: Binding<Bool>(get: {nextView == 5}, set: {_ in}))
        .alert(isPresented: $isAlert, content: {
            Alert(title: Text("STOP"), message: Text("Must be logged in to do multiplayer"), dismissButton: .cancel({isAlert = false}))
        })
        .popover(isPresented: $logView, arrowEdge: .top, content: {
            LogInView(user: $user, keepOpen: $logView)
        })
    }
}

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView()
    }
}
