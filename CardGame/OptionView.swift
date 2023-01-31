//
//  OptionView.swift
//  CardGame
//
//  Created by Kyle Hultgren on 10/9/22.
//

import SwiftUI

struct OptionView: View {
    @State private var pressed: Bool = false
    @Binding var user: User?
    
    var body: some View {
        ZStack{
            Image("mainMenuBackground")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 5){
                Spacer()
                Text("Options")
                    .font(.system(size: 28, weight: .bold))
                Divider()
                Spacer()
                
                Spacer()
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
    }
}

struct OptionView_Previews: PreviewProvider {
    @State static var user: User? = nil
    
    static var previews: some View {
        OptionView(user: $user)
    }
}
