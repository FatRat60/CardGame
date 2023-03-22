//
//  SocketDelegate.swift
//  CardGame
//
//  Created by Kyle Hultgren on 3/10/23.
//

import Foundation
import Starscream

class SocketDelegate :WebSocketDelegate {
    var isConnected : Bool = false
    
    func didReceive(event: Starscream.WebSocketEvent, client: Starscream.WebSocket) {
        switch event {
        case .connected(let headers):
            isConnected = true
            print("websocket is connected: \(headers)")
        case .disconnected(let reason, let code):
            isConnected = false
            print("websocket is disconnected: \(reason) with code: \(code)")
        case .text(let string):
            print("Reveived text: \(string)")
        case .binary(let data):
            print("Recieved data: \(data.count)")
        case .pong(_):
            break
        case .ping(_):
            break
        case .error(let error):
            isConnected = false
            print("There was a problem ig...")
            print(error as Any)
        case .viabilityChanged(_):
            break
        case .reconnectSuggested(_):
            break
        case .cancelled:
            isConnected = false
            print("socket was forcibly disconnected")
        }
    }
}
