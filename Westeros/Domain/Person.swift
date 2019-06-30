//
//  Person.swift
//  Westeros
//
//  Created by Luis Maria Tolosana Simon on 11/06/2019.
//  Copyright © 2019 Luis Maria Tolosana Simon. All rights reserved.
//

import Foundation

final class Person {
    let name: String
    let house: House
    private let _alias: String? // O tiene un nil, o tiene un String
    
    var alias: String {
        // 1: Desempaquetado civico con if-let
//        if let _alias = _alias {
//            // Existe y lo guardo en _alias (que le hace sombra a la constante privada)
//            return _alias
//        } else {
//            return ""
//        }
        
        // 2: Desempaquetado explicito (incivico) de un opcional usando !
//        return _alias! -- Esto no hay que hacerlo NUNCA (excepto en algun caso concreto)
        
        // 3: Civica: usando un guard
        // Lo veremos despues
        
        // 4: Utilizar el operador ??
        return _alias ?? "" // En este caso hace exactamente lo mismo que en nuestra solucion del punto 1
    }
    
    var fullName: String {
        return "\(name) \(house.name)"
    }
    
    init(name:String, alias: String? = nil, house: House) {
        self.name = name
        self._alias = alias
        self.house = house
        
        // Ejercicio 11. Añado el personaje que estoy creando a la lista de miembros de su casa
        // Nota: no se yo si esta muy bien hacer esto aqui en un init...
        self.house.add(person: self)
    }
    
    
}

//extension Character {
//    convenience init(name: String, house: House) {
//        self.init(name: name, alias: nil, house: house)
//    }
//}

extension Person {
    // Usamos el Patron de diseño Proxy, es decir usamos un type que ya conforme esos protocolos
    var proxyForEquality: String {
        return "\(name) \(alias) \(house.name)"
    }
    
    var proxyForComparison: String {
        return fullName
    }
}

extension Person: Equatable {
    static func == (lhs: Person, rhs: Person) -> Bool {
        // Usamos el Patron de diseño Proxy
        return lhs.proxyForEquality == rhs.proxyForEquality
    }
}

extension Person: Hashable {
    // Usamos el Patron de diseño Proxy
    //Este hashValue esta deprecado asi que usamos lo nuevo que es la funcion hash
//    var hashValue: Int {
//        return proxyForEquality.hashValue
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(alias)
        hasher.combine(house.name)
    }
}

extension Person:Comparable {
    static func < (lhs: Person, rhs: Person) -> Bool {
        return lhs.proxyForComparison < rhs.proxyForComparison
    }
    
    
}
