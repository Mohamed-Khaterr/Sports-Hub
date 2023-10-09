//
//  ASEndPoint.swift
//  Sports-Hub
//
//  Created by Khater on 01/10/2023.
//

import Foundation


protocol ASEndPoint {
    var path: String { get }
    var met: String { get }
    var params: [String: Any?] { get }
}
