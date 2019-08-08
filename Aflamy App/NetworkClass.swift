//
//  NetworkClass.swift
//  Aflamy App
//
//  Created by Ahmad Sameh on 8/7/19.
//  Copyright © 2019 Ahmad Sameh. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager {
    
    //shared instance
    static let shared = NetworkManager()
    
    let reachabilityManager = Alamofire.NetworkReachabilityManager(host: "www.google.com")
    var networkFlag : Int = 0
    func startNetworkReachabilityObserver() -> Int {
        
        reachabilityManager?.listener = { status in
            switch status {
                
            case .notReachable:
                print("The network is not reachable")
                self.networkFlag = 1
                
            case .unknown :
                print("It is unknown whether the network is reachable")
                self.networkFlag = 2
            case .reachable(.ethernetOrWiFi):
                print("The network is reachable over the WiFi connection")
                
                self.networkFlag = 3
            case .reachable(.wwan):
                print("The network is reachable over the WWAN connection")
                self.networkFlag = 4
                
            }
            
        }
        
        // start listening
        reachabilityManager?.startListening()
        print("\(self.networkFlag)")
        return networkFlag
    }
}
