//
//  ASNetworkServiceTest.swift
//  Sports-HubTests
//
//  Created by Khater on 10/10/2023.
//

import XCTest
@testable import Sports_Hub


final class ASNetworkServiceTest: XCTestCase {
    
    func test_fetchWithThreeParameters() {
        let exp = expectation(description: "waiting for API response")
        ASNetworkService.shared.fetch([League].self, sport: .football, endpoint: .leagues) { result in
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
    
    func test_fetchWithTwoParameters() {
    }
}
