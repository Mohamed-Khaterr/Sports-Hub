//
//  ASEndPointProviderTest.swift
//  Sports-HubTests
//
//  Created by Khater on 11/10/2023.
//

import XCTest
@testable import Sports_Hub

final class ASEndPointProviderTest: XCTestCase {

    func test_footballEndPoint() {
        let endpoint: ASEndPointProvider = Football.fixtures(from: "2023-09-28", to: "2023-10-6")
        
        XCTAssertEqual(endpoint.path, "football")
        XCTAssertEqual(endpoint.met, "Fixtures")
        XCTAssertEqual(endpoint.params["from"] as? String, "2023-09-28")
        XCTAssertEqual(endpoint.params["to"] as? String, "2023-10-6")
    }
    
    func test_basketballEndPoint() {
        let endpoint: ASEndPointProvider = Basketball.events(from: "2023-09-28", to: "2023-10-6")
        
        XCTAssertEqual(endpoint.path, "basketball")
        XCTAssertEqual(endpoint.met, "Fixtures")
        XCTAssertEqual(endpoint.params["from"] as? String, "2023-09-28")
        XCTAssertEqual(endpoint.params["to"] as? String, "2023-10-6")
    }
    
    func test_cricketEndPoint() {
        let endpoint: ASEndPointProvider = Cricket.events(from: "2023-09-28", to: "2023-10-6")
        
        XCTAssertEqual(endpoint.path, "cricket")
        XCTAssertEqual(endpoint.met, "Fixtures")
        XCTAssertEqual(endpoint.params["from"] as? String, "2023-09-28")
        XCTAssertEqual(endpoint.params["to"] as? String, "2023-10-6")
    }

}
