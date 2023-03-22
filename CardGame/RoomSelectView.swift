//
//  RoomSelectView.swift
//  CardGame
//
//  Created by Kyle Hultgren on 3/8/23.
//

import SwiftUI
import Starscream

struct SelectView: View {
    @Binding var clickJoin: Bool
    @Binding var clickHost: Bool
    
    var body: some View {
        VStack{
            Text("Create/Join Room")
                .font(.system(size: 28, weight: .bold))
            Divider()
            ZStack{
                Rectangle()
                    .fill(Color.blue)
                    .frame(width: 300, height: 400)
                    .cornerRadius(30)
                    .shadow(radius: 30)
                VStack{
                    Text("Join already existing room")
                    Button(action: {clickJoin = true}, label: {
                        Text("Join")
                            .padding()
                            .font(.title)
                            .foregroundColor(.black)
                            .background(Color.purple)
                            .cornerRadius(30)
                    })
                    Text("Host your own room for others to join")
                    Button(action: {clickHost = true}, label: {
                        Text("Create")
                            .padding()
                            .font(.title)
                            .foregroundColor(.black)
                            .background(Color.purple)
                            .cornerRadius(30)
                    })
                }
            }
        }
    }
}

struct RoomSelectView: View {
    @State private var clickJoin: Bool = false
    @State private var clickHost: Bool = false
    @State private var socket: WebSocket? = nil
    private var delegate: SocketDelegate = SocketDelegate()
    
    var body: some View {
        ZStack{
            Image("mainMenuBackground")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            Spacer()
            if (!clickJoin){
                SelectView(clickJoin: $clickJoin, clickHost: $clickHost)
            }
            Spacer()
        }
        .onAppear(perform: {
            var req = URLRequest(url: URL(fileURLWithPath: "http://localhost:9696"))
            req.timeoutInterval = 5
            socket = WebSocket(request: req)
            socket?.delegate = delegate
            socket?.connect()
        })
    }
}

struct RoomSelectView_Previews: PreviewProvider {
    static var previews: some View {
        RoomSelectView()
    }
}
