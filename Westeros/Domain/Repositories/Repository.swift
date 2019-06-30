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

enum HouseName: String {
    case Stark = "Stark"
    case Lannister = "Lannister"
    case Targaryen = "Targaryen"
}

protocol HouseFactory {
    var houses: [House] { get }
    
    func house(named: String) -> House?
    func house(named: HouseName) -> House?
    
    typealias HouseFilter = (House) -> Bool
    func houses(filteredBy: HouseFilter) -> [House]
}

protocol SeasonFactory {
    var seasons: [Season] { get}
   
    typealias SeasonFilter = (Season) -> Bool
    func seasons(filteredBy: SeasonFilter) -> [Season]

}

final class LocalFactory: HouseFactory, SeasonFactory {
    
    // MARK: - HouseFactory
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
        let _ = Person(name: "Robb", alias: "El Joven Lobo", house: starkHouse)
        let _ = Person(name: "Arya", house: starkHouse)
        let _ = Person(name: "Tyrion", alias: "El Enano", house: lannisterHouse)
        let _  = Person(name: "Jaime", alias: "El Matarreyes", house: lannisterHouse)
        let _ = Person(name: "Cersei", house: lannisterHouse)
        let _ = Person(name: "Daenerys", alias: "La Madre de Dragones", house: targaryenHouse)
 
        // Ejercicio 11. Dado que he metido en el init de Person que añada el personaje que se esta creando a la lista de miembros de su casa, ya no es necesario hacer aqui esa asignacion, ni individual ni "todos a la vez"
        // Y claro, como ya no se usan los nombres de las instancias de personaje creado, no hace falta ponerles nombre y se puede reemplazar por el simbolo anonimo
        
//        starkHouse.add(person: arya)
//        starkHouse.add(person: robb)
        // starkHouse.add(persons: arya, robb)  // comentado por el ejercicio 11
//        lannisterHouse.add(person: tyrion)
//        lannisterHouse.add(person: jaime)
//        lannisterHouse.add(person: cersei)
        // lannisterHouse.add(persons: tyrion, jaime, cersei)   // comentado por el ejercicio 11
        
        // targaryenHouse.add(person: dani) // Comentado por el ejercicio 11
        
        return [starkHouse, lannisterHouse, targaryenHouse].sorted()
    }
    
    func house(named name: String) -> House? {
//        return houses.filter { $0.name == name }.first
        return houses.first { $0.name.uppercased() == name.uppercased() } // filter + first
    }
    
    func house(named name: HouseName) -> House? {
        return houses.first { $0.name == name.rawValue}
    }
    
    func houses(filteredBy theFilter: (House) -> Bool) -> [House] {
        return houses.filter(theFilter)
    }
    
    
    // MARK: - Ejercicio 3 SeasonFactory
    var seasons: [Season] {
        
        // MARK: Temporada 1
        let s01E01Aired = "17/04/2011"
        let s01E02Aired = "24/04/2011"
        let s01Aired = "17/04/2011"
        
        let s01E01 = Episode(
            title: "Se acerca el Invierno",
            firstAired: s01E01Aired.toDate()
        )
        
        let s01E02 = Episode(
            title: "El Camino Real",
            firstAired: s01E02Aired.toDate()
        )
        
        let s01 = Season(
            name: "Temporada Uno",
            firstAired: s01Aired.toDate(),
            episodes: [s01E01, s01E02]
        )
        
        s01E01.add(season: s01)
        s01E02.add(season: s01)
        

        // MARK: Temporada 2
        let s02E01Aired = "01/04/2012"
        let s02E02Aired = "08/04/2012"
        let s02Aired = "01/04/2012"

        let s02E01 = Episode(
            title: "El Norte no olvida",
            firstAired: s02E01Aired.toDate()
        )

        let s02E02 = Episode(
            title: "Las Tierras de la Noche",
            firstAired: s02E02Aired.toDate()
        )

        let s02 = Season(
            name: "Temporada Dos",
            firstAired: s02Aired.toDate(),
            episodes: [s02E01, s02E02]
        )
        
        s02E01.add(season: s02)
        s02E02.add(season: s02)
        
        
        // MARK: Temporada 3
        let s03E01Aired = "31/03/2013"
        let s03E02Aired = "07/04/2013"
        let s03Aired = "31/03/2013"
        
        let s03E01 = Episode(
            title: "Valar Dohaeris",
            firstAired: s03E01Aired.toDate()
        )
        
        let s03E02 = Episode(
            title: "Alas negras, palabras negras",
            firstAired: s03E02Aired.toDate()
        )
        
        let s03 = Season(
            name: "Temporada Tres",
            firstAired: s03Aired.toDate(),
            episodes: [s03E01, s03E02]
        )
        
        s03E01.add(season: s03)
        s03E02.add(season: s03)

        
        // MARK: Temporada 4
        let s04E01Aired = "06/04/2014"
        let s04E02Aired = "13/04/2014"
        let s04Aired = "06/04/2014"
        
        let s04E01 = Episode(
            title: "Dos espadas",
            firstAired: s04E01Aired.toDate()
        )
        
        let s04E02 = Episode(
            title: "El leon y la rosa",
            firstAired: s04E02Aired.toDate()
        )
        
        let s04 = Season(
            name: "Temporada Cuatro",
            firstAired: s04Aired.toDate(),
            episodes: [s04E01, s04E02]
        )
        
        s04E01.add(season: s04)
        s04E02.add(season: s04)

        
        // MARK: Temporada 5
        let s05E01Aired = "12/04/2015"
        let s05E02Aired = "19/04/2015"
        let s05Aired = "12/04/2015"
        
        let s05E01 = Episode(
            title: "Las guerras venideras",
            firstAired: s05E01Aired.toDate()
        )
        
        let s05E02 = Episode(
            title: "La Casa de Negro y Blanco",
            firstAired: s05E02Aired.toDate()
        )
        
        let s05 = Season(
            name: "Temporada Cinco",
            firstAired: s05Aired.toDate(),
            episodes: [s05E01, s05E02]
        )
        
        s05E01.add(season: s05)
        s05E02.add(season: s05)

        
        // MARK: Temporada 6
        let s06E01Aired = "24/04/2016"
        let s06E02Aired = "01/05/2016"
        let s06Aired = "24/04/2016"
        
        let s06E01 = Episode(
            title: "La mujer roja",
            firstAired: s06E01Aired.toDate()
        )
        
        let s06E02 = Episode(
            title: "A casa",
            firstAired: s06E02Aired.toDate()
        )
        
        let s06 = Season(
            name: "Temporada Seis",
            firstAired: s06Aired.toDate(),
            episodes: [s06E01, s06E02]
        )
        
        s06E01.add(season: s06)
        s06E02.add(season: s06)

        
        // MARK: Temporada 7
        let s07E01Aired = "16/07/2017"
        let s07E02Aired = "23/07/2017"
        let s07Aired = "16/07/2017"
        
        let s07E01 = Episode(
            title: "Rocadragon",
            firstAired: s07E01Aired.toDate()
        )
        
        let s07E02 = Episode(
            title: "Bajo la tormenta",
            firstAired: s07E02Aired.toDate()
        )
        
        let s07 = Season(
            name: "Temporada Siete",
            firstAired: s07Aired.toDate(),
            episodes: [s07E01, s07E02]
        )
        
        s07E01.add(season: s07)
        s07E02.add(season: s07)

        
        return [s01, s02, s03, s04, s05, s06, s07].sorted()
    }

    func seasons(filteredBy theFilter: (Season) -> Bool) -> [Season] {
        return seasons.filter(theFilter)
    }

    
}
