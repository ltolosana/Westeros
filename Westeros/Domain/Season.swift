//
//  Season.swift
//  Westeros
//
//  Created by Luis Maria Tolosana Simon on 22/06/2019.
//  Copyright © 2019 Luis Maria Tolosana Simon. All rights reserved.
//

import Foundation

// TODO: Cambiar esto a un set de Episodios y no de Strings
typealias Episodes = Set<String>

final class Season {
    let name: String
    let firstAired: Date
    let episodes: Episodes
    
    init(name: String, firstAired: Date, episodes: Episodes) {
        self.name = name
        self.firstAired = firstAired
        self.episodes = episodes
    }
    
    // TODO: Debo revisar lo de las referencias entre Season y Episode y hacerlo como en House y Person, solo que aqui sera Episode quien se parezca a House, en el sendido de tener que añadir a posteriori loa temporada a la que pertenece el episodio
    
    // Es decir para crear la season debo tener ya un episodio, y cuando ya tengo la season es cuando le digo al episodio a que season pertenece (por eso es opcional)
}

extension Season {
    var proxyForEquality: String {
        return "\(name) \(firstAired)"
    }
    
    var proxyForComparison: Date {
        return firstAired
    }
}

extension Season: Equatable {
    static func == (lhs: Season, rhs: Season) -> Bool {
        return lhs.proxyForEquality == rhs.proxyForEquality
    }
}

extension Season: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(firstAired)
    }
}

extension Season: Comparable {
    static func < (lhs: Season, rhs: Season) -> Bool {
        return lhs.proxyForComparison < rhs.proxyForComparison
    }
}

extension Season: CustomStringConvertible {
    var description: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.locale = Locale(identifier: "es_ES")
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let listaEpisodios = episodes.map{ $0 }
        return "Temporada: \(name), con fecha de primera emision el dia: \(dateFormatter.string(from: firstAired)), cuyos episodios son: \(listaEpisodios.description)"
     }
}
