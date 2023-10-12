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
        var footall_enum = Football.countries
        XCTAssertEqual(footall_enum.path, "football")
        XCTAssertEqual(footall_enum.met, "Countries")
        
        var footall_enum2 = Football.leagues(countryID: 1)
        XCTAssertEqual(footall_enum2.met, "Leagues")
        XCTAssertEqual(footall_enum2.params["countryId"] as? Int, 1)
        
        var footall_enum3 = Football.fixtures(from: "2023-09-28", to: "2023-10-6", timezone: "time_zone_input", leagueID: 3)
        XCTAssertEqual(footall_enum3.met, "Fixtures")
        XCTAssertEqual(footall_enum3.params["from"] as? String, "2023-09-28")
        XCTAssertEqual(footall_enum3.params["to"] as? String, "2023-10-6")
        XCTAssertEqual(footall_enum3.params["timezone"] as? String, "time_zone_input")
        XCTAssertEqual(footall_enum3.params["leagueId"] as? Int, 3)
        
        var footall_enum4 = Football.team(id: 1)
        XCTAssertEqual(footall_enum4.met, "Teams")
        XCTAssertEqual(footall_enum4.params["teamId"] as? Int, 1)
        
        var footall_enum5 = Football.teams(leagueID: 2)
        XCTAssertEqual(footall_enum5.met, "Teams")
        XCTAssertEqual(footall_enum5.params["leagueId"] as? Int, 2)
        
    }
    
    func test_basketballEndPoint() {
        var basketball_enum1 = Basketball.leagues
        XCTAssertEqual(basketball_enum1.path, "basketball")
        XCTAssertEqual(basketball_enum1.met, "Leagues")
        
        var basketball_enum2 = Basketball.events(from: "2023-09-28", to: "2023-10-6", leagueID: 1)
        XCTAssertEqual(basketball_enum2.met, "Fixtures")
        XCTAssertEqual(basketball_enum2.params["from"] as? String, "2023-09-28")
        XCTAssertEqual(basketball_enum2.params["to"] as? String, "2023-10-6")
        XCTAssertEqual(basketball_enum2.params["leagueId"] as? Int, 1)
        
        var basketball_enum3 = Basketball.teams(leagueID: 2)
        XCTAssertEqual(basketball_enum3.met, "Teams")
        XCTAssertEqual(basketball_enum3.params["leagueId"] as? Int, 2)
        
        var basketball_enum4 = Basketball.team(id: 3)
        XCTAssertEqual(basketball_enum4.met, "Teams")
        XCTAssertEqual(basketball_enum4.params["teamId"] as? Int, 3)
        
    }
    
    func test_cricketEndPoint() {
        var cricket_enum1 = Cricket.leagues
        XCTAssertEqual(cricket_enum1.path, "cricket")
        XCTAssertEqual(cricket_enum1.met, "Leagues")
        
        var cricket_enum2 = Cricket.events(from: "2023-09-28", to: "2023-10-6", leagueID: 1)
        XCTAssertEqual(cricket_enum2.met, "Fixtures")
        XCTAssertEqual(cricket_enum2.params["from"] as? String, "2023-09-28")
        XCTAssertEqual(cricket_enum2.params["to"] as? String, "2023-10-6")
        XCTAssertEqual(cricket_enum2.params["leagueId"] as? Int, 1)
        
        var cricket_enum3 = Cricket.teams(leagueID: 2)
        XCTAssertEqual(cricket_enum3.met, "Teams")
        XCTAssertEqual(cricket_enum3.params["leagueId"] as? Int, 2)
        
        var cricket_enum4 = Cricket.team(id: 3)
        XCTAssertEqual(cricket_enum4.met, "Teams")
        XCTAssertEqual(cricket_enum4.params["teamId"] as? Int, 3)
    }

}
