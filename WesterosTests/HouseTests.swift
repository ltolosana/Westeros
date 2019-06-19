//
//  HouseTests.swift
//  WesterosTests
//
//  Created by Luis Maria Tolosana Simon on 11/06/2019.
//  Copyright © 2019 Luis Maria Tolosana Simon. All rights reserved.
//

import XCTest
@testable import Westeros

class HouseTests: XCTestCase {

    var starkSigil: Sigil!
    var lannisterSigil: Sigil!
    
    var starkHouse: House!
    var lannisterHouse: House!
    
    var robb: Person!
    var arya: Person!
    var tyrion: Person!
    
    var starkURL: URL!
    var lannisterURL: URL!
//    var targaryenURL: URL!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        starkURL = URL(string: "https://awoiaf.westeros.org/index.php/House_Stark")!
        lannisterURL = URL(string: "https://awoiaf.westeros.org/index.php/House_Lannister")!
//        targaryenURL = URL(string: "https://awoiaf.westeros.org/index.php/House_Targaryen")!

        starkSigil = Sigil(description: "Lobo Huargo", image: UIImage())
        lannisterSigil = Sigil(description: "Leon Rampante", image: UIImage())
        
        starkHouse = House(
            name: "Stark",
            sigil: starkSigil,
            words: "Se acerca el invierno",
            url: starkURL
        )
        
        lannisterHouse = House(
            name: "Lannister",
            sigil: lannisterSigil,
            words: "Oye mi rugido",
            url: lannisterURL
        )

        robb = Person(name: "Robb", alias: "El Joven Lobo", house: starkHouse)
        arya = Person(name: "Arya", house: starkHouse)
        tyrion = Person(name: "Tyrion", alias: "El Gnomo", house: lannisterHouse)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }


    func testHouseExistence() {
         XCTAssertNotNil(starkHouse)
    }

    func testSigilExistence() {
        XCTAssertNotNil(starkSigil)
    }
    
    // Los nombre de los test sueen usar esta nomenclatura: Given - When - Then
    func testHouseAddPersons() {
        XCTAssertEqual(starkHouse.count, 0)
        
        starkHouse.add(person: robb)
        XCTAssertEqual(starkHouse.count, 1)
        
        starkHouse.add(person: arya)
        XCTAssertEqual(starkHouse.count, 2)
        
        starkHouse.add(person: arya)
        XCTAssertEqual(starkHouse.count, 2)
        
        starkHouse.add(person: tyrion)
        XCTAssertEqual(starkHouse.count, 2)
    }
    
    func testHouseAddPersonsAtOnce() {
        starkHouse.add(persons: robb, arya, tyrion)
        XCTAssertEqual(starkHouse.count, 2)
    }
    
    func testHouseEquality() {
        // 1. Identidad
        XCTAssertEqual(starkHouse, starkHouse)
        
        // 2. Igualdad
        let jinxed = House(name: "Stark", sigil: starkSigil, words: "Se acerca el invierno", url: starkURL)
        XCTAssertEqual(starkHouse, jinxed)
        
        // 3. Desigualdad
        XCTAssertNotEqual(starkHouse, lannisterHouse)
    }
    
    func testHouseComparison() {
        XCTAssertLessThan(lannisterHouse, starkHouse)
        XCTAssertGreaterThan(starkHouse, lannisterHouse)
        XCTAssertLessThanOrEqual(lannisterHouse, starkHouse)
        XCTAssertGreaterThanOrEqual(starkHouse, lannisterHouse)
    }
    
    func testHouseSortedMembersReturnsASortedListOfMembers() {
        starkHouse.add(persons: robb, arya)
        
        XCTAssertEqual(starkHouse.count, 2)
        
        XCTAssertEqual(starkHouse.sortedMembers, [arya, robb])
        XCTAssertEqual(starkHouse.sortedMembers, starkHouse.sortedMembers.sorted())
        
    }
}
