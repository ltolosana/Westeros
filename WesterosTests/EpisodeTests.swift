//
//  EpisodeTests.swift
//  WesterosTests
//
//  Created by Luis Maria Tolosana Simon on 22/06/2019.
//  Copyright © 2019 Luis Maria Tolosana Simon. All rights reserved.
//

import XCTest
@testable import Westeros

class EpisodeTests: XCTestCase {

    var s01E01: Episode!
    let s01E01Aired = "17/04/2011"
    
    var s01: Season!
    let s01Aired = "17/04/2011"
    
    override func setUp() {
        s01 = Season(name: "Temporada Uno", firstAired: Date().fromString(s01Aired), episodes: ["uno", "dos"])
        
        s01E01 = Episode(title: "Se acerca el Invierno", firstAired: Date().fromString("s01E01Aired"), season: s01)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testEpisodeExistence() {
        XCTAssertNotNil(s01E01)
    }

}
