//
//  SeasonTests.swift
//  WesterosTests
//
//  Created by Luis Maria Tolosana Simon on 22/06/2019.
//  Copyright © 2019 Luis Maria Tolosana Simon. All rights reserved.
//

import XCTest
@testable import Westeros

class SeasonTests: XCTestCase {

    var seasonOne: Season!
    
    override func setUp() {
        let seasonOneDate = "17/04/2011"
        
//        seasonOne = Season(name: "Temporada Uno", firstAired: Date(timeIntervalSince1970: 1302552000), episodes: ["uno", "dos"])
        seasonOne = Season(name: "Temporada Uno", firstAired: Date().fromString(seasonOneDate), episodes: ["uno", "dos"])
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSeasonExistance() {
        print("FEcha emision: \(seasonOne.firstAired)")
        XCTAssertNotNil(seasonOne)
    }

}
