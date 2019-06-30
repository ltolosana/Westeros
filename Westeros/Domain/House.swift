//
//  House.swift
//  Westeros
//
//  Created by Luis Maria Tolosana Simon on 11/06/2019.
//  Copyright © 2019 Luis Maria Tolosana Simon. All rights reserved.
//

import Foundation

typealias Words = String
typealias Members = Set<Person> // Tipo Set en vez de tipo array, porque el tipo Set no permite duplicados

final class House {
    let name: String
    let sigil: Sigil
    let words: Words
    let wikiURL: URL
    private var _members: Members
    
    init(name: String, sigil:Sigil, words: Words, url: URL) {
        self.name = name
        self.sigil = sigil
        self.words = words
        self.wikiURL = url
        _members = Members()
    }
}

extension House {
    var count: Int {
        return _members.count
    }
    
    var sortedMembers: [Person] {
        return _members.sorted()
    }
    
    func add(person: Person) {
        if self == person.house{
            _members.insert(person)
        }
    }
    
    // Funcionaes variadicas
    func add(persons: Person...) {
        //persons: aqui dentro es como si fuera un array de person es decir [person]
        persons.forEach { add(person: $0) } // Esto es equivalente a lo comentado de debajo
        
//        for person in persons {
//            add(person: person)
//        }
    }
}

extension House {
    var proxyForEquality: String {
        return "\(name) \(words) \(count)"
    }
    
    var proxyForComparison: String {
        return name.uppercased()
    }
}

extension House: Equatable {
    static func == (lhs: House, rhs: House) -> Bool {
        return lhs.proxyForEquality == rhs.proxyForEquality
    }
}

extension House: Comparable {
    static func < (lhs: House, rhs: House) -> Bool {
        // Necesitamos alguna logica para definir cuando lhs < rhs
        return lhs.proxyForComparison < rhs.proxyForComparison
    }
    
    
}


