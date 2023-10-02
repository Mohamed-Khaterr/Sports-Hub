//
//  ASDataResponse.swift
//  Sports-Hub
//
//  Created by Khater on 01/10/2023.
//

import Foundation


struct ASDataResponse<T: Decodable>: Decodable {
    let success: Int
    let result: T?
}
