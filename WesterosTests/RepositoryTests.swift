//
//  RepositoryTests.swift
//  WesterosTests
//
//  Created by Luis Maria Tolosana Simon on 13/06/2019.
//  Copyright © 2019 Luis Maria Tolosana Simon. All rights reserved.
//

import XCTest
@testable import Westeros

class RepositoryTests: XCTestCase {

    override func setUp() {

    }

    override func tearDown() {

    }

    func testLocalRepositoryExistence() {
        XCTAssertNotNil(Repository.local)
    }

    func testLocalFactoryHasHouses() {
        let houses = Repository.local.houses
        XCTAssertNotNil(houses)
    }
    
    func testLocalFactoryHasTheCorrectHouseCount() {
        let houses = Repository.local.houses
        XCTAssertEqual(houses.count, 3)
    }
    
    func testLocalRepositoryReturnsSortedArrayOfHouses() {
        let houses = Repository.local.houses
        XCTAssertEqual(houses, houses.sorted())
    }
    
    func testLocalRepositoryReturnsHouseByNameCaseInsensitively() {
        let stark = Repository.local.house(named: "Stark")
        XCTAssertNotNil(stark)
        
        let lannister = Repository.local.house(named: "lAnniSteR")
        XCTAssertNotNil(lannister)
        
        let keepcoding = Repository.local.house(named: "Keepcoding")
        XCTAssertNil(keepcoding)
    }
    
    func testLocalRepositoryHouseFiltering() {
        //let filteredHouseList = Repository.local.houses(filteredBy: { $0.count == 1 })
        let filteredHouseList = Repository.local.houses(filteredBy: { house in
            house.count == 1
        })
        XCTAssertEqual(filteredHouseList.count, 1)
        
        let list = Repository.local.houses(filteredBy: { $0.words == "Se acerca el verano" })
        XCTAssertEqual(list.count, 0)
    }
}
