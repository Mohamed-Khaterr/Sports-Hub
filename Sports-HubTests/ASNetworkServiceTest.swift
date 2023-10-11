//
//  ASNetworkServiceTest.swift
//  Sports-HubTests
//
//  Created by Khater on 10/10/2023.
//

import XCTest
@testable import Sports_Hub

final class ASNetworkServiceTest: XCTestCase {
    
    func test_footballEndPoint() {
        let endpoint: ASEndPointProvider = Football.fixtures(from: "2023-09-28", to: "2023-10-6")
        
        XCTAssertEqual(endpoint.path, "football")
        XCTAssertEqual(endpoint.met, "Fixtures")
        XCTAssertEqual(endpoint.params["from"] as? String, "2023-09-28")
        XCTAssertEqual(endpoint.params["to"] as? String, "2023-10-6")
    }
    
    func test_ASEndPointManager() {
        let endpointManager = ASEndPointProviderManager(Football.fixtures(from: "2023-09-28", to: "2023-10-6"))
        
        // apiv2.allsportsapi.com/football?met=Fixtures&from=2023-09-28&to=2023-10-6&APIkey={{AllSportsAPIKey}}
        XCTAssertEqual(endpointManager.urlString(), "https://apiv2.allsportsapi.com/football")
        
        XCTAssertTrue(endpointManager.parameters().contains(where: { $0.key == "APIkey" }))
        XCTAssertTrue(endpointManager.parameters().contains(where: { $0.key == "met" }))
    }
    
    func test_fetchWithTwoParameters() {
        let exp = expectation(description: "waiting for API response")
        ASNetworkService.shared.fetch([League].self, endpoint: Football.leagues()) { result in
            switch result {
            case .success(let leagues):
                XCTAssertGreaterThan(leagues.count, 0, "Leagues is less than 0")
                exp.fulfill()
            case .failure(let error):
                XCTFail("Service error: \(error)")
                exp.fulfill()
            }
        }
        waitForExpectations(timeout: 5)
    }

}
