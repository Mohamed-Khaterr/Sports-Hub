//
//  InternetMointor.swift
//  Sports-Hub
//
//  Created by Khater on 09/10/2023.
//

import Foundation
import Network


final class InternetMointor {
    static let shared = InternetMointor()
    
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue.global(qos: .background)
    public private(set) var isConnected = false
    
    private init () {}
    
    func start() {
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { path in
            self.isConnected = (path.status == .satisfied)
            let message = (path.status == .satisfied) ? "Connected" : "Disconnected"
            print("Internet is \(message)")
        }
    }
}
