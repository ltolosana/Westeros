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

    var s01E01: Episode!
    var s01E02: Episode!
    var s01E03: Episode!
    var s01E04: Episode!
    var s01E05: Episode!
    var s01: Season!

    var s02E01: Episode!
    var s02: Season!
    
    override func setUp() {
        let s01E01Aired = "17/04/2011"
        let s01E02Aired = "24/04/2011"
        let s01E03Aired = "01/05/2011"
        let s01E04Aired = "08/05/2011"
        let s01E05Aired = "15/05/2011"
        let s01Aired = "17/04/2011"
        
        let s02E01Aired = "01/04/2012"
        let s02Aired = "01/04/2012"
        
        s01E01 = Episode(
            title: "Se acerca el Invierno",
            firstAired: s01E01Aired.toDate()
        )
        
        s01E02 = Episode(
            title: "El Camino Real",
            firstAired: s01E02Aired.toDate()
        )

        s01E03 = Episode(
            title: "Lord Nieve",
            firstAired: s01E03Aired.toDate()
        )

        s01E04 = Episode(
            title: "Tullidos, bastardos y cosas rotas",
            firstAired: s01E04Aired.toDate()
        )

        s01E05 = Episode(
            title: "El Lobo y el Leon",
            firstAired: s01E05Aired.toDate()
        )

        s01 = Season(
            name: "Temporada Uno",
            firstAired: s01Aired.toDate(),
            episodes: [s01E01, s01E02]
        )
        
        s02E01 = Episode(
            title: "El Norte no olvida",
            firstAired: s02E01Aired.toDate()
        )
        
        s02 = Season(
            name: "Temporada Dos",
            firstAired: s02Aired.toDate(),
            episodes: [s02E01]
        )
        
        s02E01.add(season: s02)
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
            episodes: [s01E01, s01E02]
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
        
        XCTAssertEqual(s01.description, "Temporada: Temporada Uno, con fecha de primera emision el dia: 17/04/2011, y que tiene 2 episodios.")
    }

    func testSeasonAddEpisodes() {
        XCTAssertEqual(s01.count, 2)
        
        // Añado un episodio y se incrementa el numero de episodios
        s01.add(episode: s01E03)
        XCTAssertEqual(s01.count, 3)

        // Si añado un episodio que ya existe, no se debe añadir ni incrementar el numero de episodios
        s01.add(episode: s01E03)
        XCTAssertEqual(s01.count, 3)
        
        // Si intento añadir un episodio que esta ya en otra temporada tampoco debe poder añadirse
        s01.add(episode: s02E01)
        XCTAssertEqual(s01.count, 3)
    }
    
    func testHouseAddPersonsAtOnce() {
        s01.add(episodes: s01E03, s01E04, s01E05)
        XCTAssertEqual(s01.count, 5)
    }

    func testSeasonSortedEpisodesReturnsASortedListOfEpisodes() {
        s01.add(episodes: s01E05, s01E04, s01E03)

        XCTAssertEqual(s01.count, 5)
        
        XCTAssertEqual(s01.sortedEpisodes, [s01E01, s01E02, s01E03, s01E04, s01E05])
        XCTAssertEqual(s01.sortedEpisodes, s01.sortedEpisodes.sorted())
    }

}
