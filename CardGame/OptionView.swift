//
//  OptionView.swift
//  CardGame
//
//  Created by Kyle Hultgren on 10/9/22.
//

import SwiftUI
import UIKit
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
                Button(action: {AF.request("http://localhost:6969/updateUser", method: .post, parameters: ["username":user!.username, "displayName":displayName, "profile":user!.base64Encode(), "money":String(user!.money), "wins":String(user!.wins), "gamesPlayed":String(user!.gamesPlayed)], encoder: JSONParameterEncoder.default).response { (response) in
                    // Check the status code of response
                    switch response.response?.statusCode {
                    case let code?:
                        print(code)
                        switch code {
                        // if sucess try to parse User
                        case 201:
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

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var user: User?
    @Binding var doSave: Bool
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.user!.changeProfilePic(newPfp: uiImage)
            }
            parent.doSave = true
            picker.dismiss(animated: true, completion: nil)
        }
    }
}

struct OptionView: View {
    @State private var pressed: Bool = false
    @State private var changeName: Bool = false
    @State private var doSave: Bool = false
    @State private var pickImage: Bool = false
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
                Image(uiImage: user!.profile)
                    .resizable()
                    .frame(width: 200, height: 150, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                Button(action: {pickImage = true}, label: {
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
                Button(action: {if doSave {
                    AF.request("http://localhost:6969/updateUser", method: .post, parameters: ["username":user!.username, "displayName":user!.displayName, "profile":user!.base64Encode(), "money":String(user!.money), "wins":String(user!.wins), "gamesPlayed":String(user!.gamesPlayed)], encoder: JSONParameterEncoder.default).response { (response) in
                        // Check the status code of response
                        switch response.response?.statusCode {
                        case let code?:
                            print(code)
                            switch code {
                            // if sucess try to parse User
                            case 200:
                                do {
                                    print("success")
                                }
                            default:
                                print("Could not get user")
                            }
                        case .none:
                            print("Request failed")
                        }
                    }
                }
                        pressed = true}, label: {
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
        .navigate(to: MainMenuView(user: user), when: $pressed)
        .popover(isPresented: $changeName, arrowEdge: .top, content: {
            editView(state: $changeName, user: $user)
        })
        .sheet(isPresented: $pickImage, content: {
            ImagePicker(user: $user, doSave: $doSave)
        })
    }
}

struct OptionView_Previews: PreviewProvider {
    @State static var user: User? = User(username: "FatRat60", displayName: "YeaBaby")
    
    static var previews: some View {
        OptionView(user: $user)
    }
}
