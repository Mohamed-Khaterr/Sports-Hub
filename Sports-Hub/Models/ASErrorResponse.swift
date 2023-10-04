//
//  ASErrorResponse.swift
//  Sports-Hub
//
//  Created by Khater on 01/10/2023.
//

import Foundation


struct ASErrorResponse: Decodable {
    let error: String
    let result: [ResultError]
    
    struct ResultError: Decodable {
        let code: Int
        let parameters: String?
        let message: String
        
        enum CodingKeys: String, CodingKey {
            case code = "cod"
            case parameters = "param"
            case message = "msg"
        }
    }
}
