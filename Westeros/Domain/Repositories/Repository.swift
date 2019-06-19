//
//  Repository.swift
//  Westeros
//
//  Created by Luis Maria Tolosana Simon on 13/06/2019.
//  Copyright © 2019 Luis Maria Tolosana Simon. All rights reserved.
//

import UIKit

final class Repository {
    
    static let local = LocalFactory()
}

protocol HouseFactory {
    var houses: [House] { get }
    
    func house(named: String) -> House?
    
    typealias HouseFilter = (House) -> Bool
    func houses(filteredBy: HouseFilter) -> [House]
}

final class LocalFactory: HouseFactory {
    
    var houses: [House] {
        
        // Me creo las casas
        let starkSigil = Sigil(description: "Logo Huargo", image: UIImage(named: "stark")!)
        let lannisterSigil = Sigil(description: "Leon Rampante", image: UIImage(named: "lannister")!)
        let targaryenSigil = Sigil(description: "Dragon tricefalo", image: UIImage(named: "targaryen")!)
        
        let starkURL = URL(string: "https://awoiaf.westeros.org/index.php/House_Stark")!
        let lannisterURL = URL(string: "https://awoiaf.westeros.org/index.php/House_Lannister")!
        let targaryenURL = URL(string: "https://awoiaf.westeros.org/index.php/House_Targaryen")!
        
        let starkHouse = House(
            name: "Stark",
            sigil: starkSigil,
            words: "Se acerca el invierno",
            url: starkURL
        )
        
        let lannisterHouse = House(
            name: "Lannister",
            sigil: lannisterSigil,
            words: "Oye mi rugido",
            url: lannisterURL
        )
        
        let targaryenHouse =  House(
            name: "Targaryen",
            sigil: targaryenSigil,
            words: "Fuego y Sangre",
            url: targaryenURL
        )
        
        // Add characters
        let robb = Person(name: "Robb", alias: "El Joven Lobo", house: starkHouse)
        let arya = Person(name: "Arya", house: starkHouse)
        let tyrion = Person(name: "Tyrion", alias: "El Enano", house: lannisterHouse)
        let jaime  = Person(name: "Jaime", alias: "El Matarreyes", house: lannisterHouse)
        let cersei = Person(name: "Cersei", house: lannisterHouse)
        let dani = Person(name: "Daenerys", alias: "La Madre de Dragones", house: targaryenHouse)
        
//        starkHouse.add(person: arya)
//        starkHouse.add(person: robb)
        starkHouse.add(persons: arya, robb)
//        lannisterHouse.add(person: tyrion)
//        lannisterHouse.add(person: jaime)
//        lannisterHouse.add(person: cersei)
        lannisterHouse.add(persons: tyrion, jaime, cersei)
        
        targaryenHouse.add(person: dani)
        
        return [starkHouse, lannisterHouse, targaryenHouse].sorted()
    }
    
    func house(named name: String) -> House? {
//        return houses.filter { $0.name == name }.first
        return houses.first { $0.name.uppercased() == name.uppercased() } // filter + first
    }
    
    func houses(filteredBy theFilter: (House) -> Bool) -> [House] {
        return houses.filter(theFilter)
    }
}
