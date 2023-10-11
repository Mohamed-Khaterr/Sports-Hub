//
//  ASEndPointProviderManagerTest.swift
//  Sports-HubTests
//
//  Created by Khater on 11/10/2023.
//

import XCTest
@testable import Sports_Hub

final class ASEndPointProviderManagerTest: XCTestCase {

    func test_ASEndPointManager() {
        let endpointManager = ASEndPointProviderManager(Football.fixtures(from: "2023-09-28", to: "2023-10-6"))

        // apiv2.allsportsapi.com/football?met=Fixtures&from=2023-09-28&to=2023-10-6&APIkey={{AllSportsAPIKey}}
        XCTAssertEqual(endpointManager.urlString(), "https://apiv2.allsportsapi.com/football")

        XCTAssertTrue(endpointManager.parameters().contains(where: { $0.key == "APIkey" }))
        XCTAssertTrue(endpointManager.parameters().contains(where: { $0.key == "met" }))
    }
}
