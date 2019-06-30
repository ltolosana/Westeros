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
    
    func testLocalRepositoryReturnsHouseNamedbyEnum() {
        let starkEnumed = Repository.local.house(named: .Stark)
        XCTAssertNotNil(starkEnumed)
        
        let starrkStringed = Repository.local.house(named: "Stark")
        XCTAssertEqual(starrkStringed, starkEnumed)
        
        let lannisterEnumed = Repository.local.house(named: .Lannister)
        XCTAssertNotNil(lannisterEnumed)
        
        let lannisterStringed = Repository.local.house(named: "Lannister")
        XCTAssertEqual(lannisterStringed, lannisterEnumed)

        let targaryenEnumed = Repository.local.house(named: .Targaryen)
        XCTAssertNotNil(targaryenEnumed)
        
        let targaryenStringed = Repository.local.house(named: "Targaryen")
        XCTAssertEqual(targaryenStringed, targaryenEnumed)

        XCTAssertNotEqual(starkEnumed, lannisterEnumed)
        XCTAssertNotEqual(starkEnumed, targaryenEnumed)
        XCTAssertNotEqual(lannisterEnumed, targaryenEnumed)
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
    
    func testLocalFactoryHasSeasons() {
        let seasons = Repository.local.seasons
        XCTAssertNotNil(seasons)
    }
    
    func testLocalFactoryHasTheCorrectSeasonCount() {
        let seasons = Repository.local.seasons
        XCTAssertEqual(seasons.count, 7)
    }
    
    func testLocalRepositoryReturnsSortedArrayOfSeasons() {
        let seasons = Repository.local.seasons
        XCTAssertEqual(seasons, seasons.sorted())
    }

    func testLocalRepositorySeasonFiltering() {
        //let filteredSeasonList = Repository.local.seasons(filteredBy: { $0.count == 1 })
        let filteredSeasonList = Repository.local.seasons(filteredBy: { season in
            season.count == 2
        })
        XCTAssertEqual(filteredSeasonList.count, 7)
        
        let filteredSeasonList2 = Repository.local.seasons(filteredBy: { $0.name.lowercased() == "temporada tres" })
        XCTAssertEqual(filteredSeasonList2.count, 1)
        
        let filteredSeasonList3 = Repository.local.seasons { (season) -> Bool in
            season.name == "Temporada Ocho"
        }
        XCTAssertEqual(filteredSeasonList3.count, 0)
        
    }
}
