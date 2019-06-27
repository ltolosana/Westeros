//
//  Season.swift
//  Westeros
//
//  Created by Luis Maria Tolosana Simon on 22/06/2019.
//  Copyright © 2019 Luis Maria Tolosana Simon. All rights reserved.
//

import Foundation

typealias Episodes = Set<Episode>

final class Season {
    let name: String
    let firstAired: Date
    var episodes: Episodes
    
    init(name: String, firstAired: Date, episodes: Episodes) {
        self.name = name
        self.firstAired = firstAired
        self.episodes = episodes
    }
}

extension Season {
    var count: Int {
        return episodes.count
    }
    
    var sortedEpisodes: [Episode] {
        return episodes.sorted()
    }
    
    func add(episode: Episode) {
        // Solo puedo añadir el episodio si no esta asignado a ninguna temporada
        // Y como es un Set no puede haber episodios duplicados
        if episode.season == nil {
            episodes.insert(episode)
        }
    }
    
    func add(episodes: Episode...) {
        episodes.forEach { add(episode: $0) }
    }

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
//        let listaEpisodios = episodes.sorted().map{ $0.title }
//        print(listaEpisodios)
//        return "Temporada: \(name), con fecha de primera emision el dia: \(dateFormatter.string(from: firstAired)), y que tiene \(count) episodios llamados: \(episodes.sorted().map{ $0.title })."
        return "Temporada: \(name), con fecha de primera emision el dia: \(dateFormatter.string(from: firstAired)), y que tiene \(count) episodios."
     }
}
