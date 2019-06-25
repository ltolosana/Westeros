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
    var s02: Season!
    
    override func setUp() {
        let s01Aired = "17/04/2011"
        let s02Aired = "01/04/2012"
        
//        seasonOne = Season(name: "Temporada Uno", firstAired: Date(timeIntervalSince1970: 1302552000), episodes: ["uno", "dos"])
 //       s01 = Season(name: "Temporada Uno", firstAired: Date().fromString(s01Aired), episodes: ["uno", "dos"])
        s01 = Season(
            name: "Temporada Uno",
            firstAired: s01Aired.toDate(),
            episodes: ["uno", "dos"]
        )
    
        s02 = Season(
            name: "Temporada Dos",
            firstAired: s02Aired.toDate(),
            episodes: ["uno", "dos"]
        )
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSeasonExistance() {
        print("Fecha emision: \(s01.firstAired)")
        XCTAssertNotNil(s01)
    }

    func testSeasonEquality() {
        // 1. Identidad
        XCTAssertEqual(s01, s01)
        
        // 2. Igualdad
        let temporadaUno = Season(
            name: "Temporada Uno",
            firstAired: "17/04/2011".toDate(),
            episodes: ["uno", "dos"]
        )
        XCTAssertEqual(s01, temporadaUno)
        
        // 3. Desigualdad
        XCTAssertNotEqual(s01, s02)
        
    }
    
    func testSEasonConformsToHashable() {
        XCTAssertNotNil(s01.hashValue)
    }
    
    func testSeasonComparison() {
        
        XCTAssertLessThan(s01, s02)
        XCTAssertGreaterThan(s02, s01)
        XCTAssertLessThanOrEqual(s01, s02)
        XCTAssertGreaterThanOrEqual(s02, s01)
    }
    
    func testSeasonConformsCustomStringConvertible() {
        
        XCTAssertEqual(s01.description, "Temporada: Temporada Uno, con fecha de primera emision el dia: 17/04/2011, cuyos episodios son: [\"uno\", \"dos\"]")
    }

}
