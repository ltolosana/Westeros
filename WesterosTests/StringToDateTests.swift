//
//  StringToDateTests.swift
//  WesterosTests
//
//  Created by Luis Maria Tolosana Simon on 29/06/2019.
//  Copyright © 2019 Luis Maria Tolosana Simon. All rights reserved.
//

import XCTest
@testable import Westeros

class StringToDateTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testStringWellFormedGivesCorrectDate() {
        
        XCTAssertEqual("29/06/2019".toDate(), Date.init(timeIntervalSince1970: 1561766400))
        XCTAssertEqual("01/01/1970".toDate(), Date.init(timeIntervalSince1970: 0))
    }
    
    func testStringBadFormedGivesTodayDate() {
        // Lo tengo que poner a solo la fecha, sin hora, porque siempre hay una pequeña dicherencia de milisegundos entra ambas fechas, y solo nos interesa el dia
        let fechaMalFormada = "cualquiercosa".toDate()
        let fechahoy = Date.init()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        print(dateFormatter.string(from: fechaMalFormada))
        print(dateFormatter.string(from: fechahoy))
        
        XCTAssertEqual(dateFormatter.string(from: fechaMalFormada), dateFormatter.string(from: fechahoy))
    }
    
}
