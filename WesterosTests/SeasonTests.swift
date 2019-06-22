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

    var s01: Season!
    
    override func setUp() {
        let s01Aired = "17/04/2011"
        
//        seasonOne = Season(name: "Temporada Uno", firstAired: Date(timeIntervalSince1970: 1302552000), episodes: ["uno", "dos"])
        s01 = Season(name: "Temporada Uno", firstAired: Date().fromString(s01Aired), episodes: ["uno", "dos"])
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSeasonExistance() {
        print("FEcha emision: \(s01.firstAired)")
        XCTAssertNotNil(s01)
    }

}
