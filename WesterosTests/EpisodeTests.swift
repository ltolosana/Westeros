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
    
    var s01E02: Episode!
    let s01E02Aired = "24/04/2011"
    
    var s01: Season!
    let s01Aired = "17/04/2011"
    
    override func setUp() {
        
        s01E01 = Episode(
            title: "Se acerca el Invierno",
            firstAired: s01E01Aired.toDate()
        )
        
        s01E02 = Episode(
            title: "El Camino Real",
            firstAired: s01E02Aired.toDate()
        )
        
        s01 = Season(
            name: "Temporada Uno",
            firstAired: s01Aired.toDate(),
            episodes: [s01E01, s01E02]
        )

    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testEpisodeExistence() {
        XCTAssertNotNil(s01E01)
    }

    func testEpisodeAddSeason() {
        // De inicio la temporada del capitulo esta vacia
        XCTAssertNil(s01E01.season)
        
        // Si añades una temporada, deja de estar vacia y corresponde a la temporada que debe ser
        s01E01.add(season: s01)
        XCTAssertNotNil(s01E01.season)
        XCTAssertEqual(s01E01.season, s01)
        
        let s02E01 = Episode(
            title: "El Norte no olvida",
            firstAired: "01/04/2012".toDate()
        )
        
        let s02 = Season(
            name: "Temporada Dos",
            firstAired: "01/04/2012".toDate(),
            episodes: [s02E01]
        )

        // No se puede añadir una temporada que no corresponde
        s02E01.add(season: s01)
        XCTAssertNil(s02E01.season)
    }

    func testEpisodeEquality() {
        // 1. Identidad
        XCTAssertEqual(s01E01, s01E01)
        
        // 2. Igualdad
        let temporadaUnoEpisodioUno = Episode(
            title: "Se acerca el Invierno",
            firstAired: "17/04/2011".toDate(),
            season: s01
        )
        XCTAssertEqual(s01E01, temporadaUnoEpisodioUno)
        
        // 3. Desigualdad
        XCTAssertNotEqual(s01E01, s01E02)
        
    }
    
    func testEpisodeConformsToHashable() {
        XCTAssertNotNil(s01E01.hashValue)
    }
    
    func testEpisodeComparison() {
        
        XCTAssertLessThan(s01E01, s01E02)
        XCTAssertGreaterThan(s01E02, s01E01)
        XCTAssertLessThanOrEqual(s01E01, s01E02)
        XCTAssertGreaterThanOrEqual(s01E02, s01E01)
    }
    
    func testEpisodeConformsCustomStringConvertible() {
        s01E01.add(season: s01)
        XCTAssertEqual(s01E01.description, "Episodio: Se acerca el Invierno, correspondiente a la temporada: Temporada Uno, emitido el dia: 17/04/2011")
        XCTAssertEqual(s01E02.description, "Episodio: El Camino Real, emitido el dia: 24/04/2011")
    }

}
