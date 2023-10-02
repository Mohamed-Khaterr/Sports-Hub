//
//  AllSportsNetworkProvider.swift
//  Sports-Hub
//
//  Created by Khater on 01/10/2023.
//

import Foundation


protocol AllSportsNetworkProvider {
    func fetch<T: Decodable>(_ type: T.Type, endpoint: AllSportsAPIEndPoint, compeletionHandler: @escaping (Result<T, Error>) -> Void)
}
