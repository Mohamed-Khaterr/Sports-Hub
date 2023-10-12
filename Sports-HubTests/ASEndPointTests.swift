//
//  ASEndPointTests.swift
//  Sports-HubTests
//
//  Created by Khater on 11/10/2023.
//

import XCTest
@testable import Sports_Hub

final class ASEndPointTests: XCTestCase {

    func test_ASEndPoint() {
        // https://apiv2.allsportsapi.com/football?met=Fixtures&from=2023-09-28&to=2023-10-6&APIkey={{AllSportsAPIKey}}
        let endpoint = ASEndPoint.events(from: "2023-09-28", to: "2023-10-6", leagueID: 51)
        XCTAssertEqual(endpoint.met, "Fixtures")
        XCTAssertEqual(endpoint.params["from"] as? String, "2023-09-28")
        XCTAssertEqual(endpoint.params["to"] as? String, "2023-10-6")
        XCTAssertEqual(endpoint.params["leagueId"] as? Int, 51)
    }

}
