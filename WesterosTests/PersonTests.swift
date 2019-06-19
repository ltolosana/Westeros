//
//  PersonTests.swift
//  WesterosTests
//
//  Created by Luis Maria Tolosana Simon on 11/06/2019.
//  Copyright © 2019 Luis Maria Tolosana Simon. All rights reserved.
//

import XCTest
@testable import Westeros

class PersonTests: XCTestCase {

    // Opcional explicitamente desempaquetado
    // Tiene sentido por dos cosas
    // 1. Si me olvido de darle un valor, quiero que "crashee"
    // 2. En este caso no controlamos cuando se hace el init de esta clase (en los tests nunca se va a usar un init, por eso no podemos crearlo y nunca le dariamos un valor si fuera un opcional normal y corriente Sigil?
    
    var starkSigil: Sigil!  // Le estamos diciendo que es un opcional (?) pero que "la caja ya esta abierta"
    var lannisterSigil: Sigil!
    var starkHouse: House!  // Igual que arriba
    var lannisterHouse: House!
    var ned: Person!
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
        
        lannisterHouse = House(name: "Lannister", sigil: lannisterSigil, words: "Oye mi rugido", url: lannisterURL)

        ned = Person(name: "Eddard", alias: "Ned", house: starkHouse)
        tyrion = Person(name: "Tyrion", alias: "El Gnomo", house: lannisterHouse)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
    func testCharacterExistence() {
        XCTAssertNotNil(ned)
        
    }

    func testCharacterExistenceWithoutAlias() {
       let arya = Person(name: "Arya", house: starkHouse)
        XCTAssertNotNil(arya)
        XCTAssertEqual(arya.alias, "")
    }
    
    func testPersonFullName() {
        XCTAssertEqual(ned.fullName, "Eddard Stark")
    }
    
    func testPersonConformsToHashable() {
        XCTAssertNotNil(ned.hashValue)
    }
    
    func testPersonEquality() {
        // 1. Identidad
        XCTAssertEqual(ned, ned)
        
        // 2. Igualdad
        let eddard = Person(name: "Eddard", alias: "Ned", house: starkHouse)
        XCTAssertEqual(ned, eddard)
        
        // 3. Desigualdad
        XCTAssertNotEqual(ned, tyrion)
        
    }
}
