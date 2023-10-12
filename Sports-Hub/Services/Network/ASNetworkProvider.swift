//
//  ASNetworkProvider.swift
//  Sports-Hub
//
//  Created by Khater on 01/10/2023.
//

import Foundation


protocol ASNetworkProvider {
    func fetch<T: Decodable>(_ type: T.Type, endpoint: ASEndPointProvider, compeletionHandler: @escaping (Result<T, NetworkError>) -> Void)
}
