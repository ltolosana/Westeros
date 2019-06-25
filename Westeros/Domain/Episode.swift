//
//  Episode.swift
//  Westeros
//
//  Created by Luis Maria Tolosana Simon on 22/06/2019.
//  Copyright © 2019 Luis Maria Tolosana Simon. All rights reserved.
//

import Foundation

final class Episode {
    let title: String
    let firstAired: Date
    weak var season: Season?
    
    init(title: String, firstAired: Date, season: Season? = nil) {
        self.title = title
        self.firstAired = firstAired
        self.season = season
    }
    //TODO: Debo revisar esto de las referencias entre season y episode
    // VEr lo que he puesto en Season
}

extension Episode {
    var proxyForEquality: String {
        return "\(title) \(firstAired)"
    }
    
    var proxyForComparison: Date {
        return firstAired
    }
}

extension Episode: Equatable {
    static func == (lhs: Episode, rhs: Episode) -> Bool {
        return lhs.proxyForEquality == rhs.proxyForEquality
    }
}

extension Episode: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
        hasher.combine(firstAired)
    }
}

extension Episode: Comparable {
    static func < (lhs: Episode, rhs: Episode) -> Bool {
        return lhs.proxyForComparison < rhs.proxyForComparison
    }
}

extension Episode: CustomStringConvertible {
    var description: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.locale = Locale(identifier: "es_ES")
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        if let season = season {
            return "Episodio: \(title), correspondiente a la temporada: \(season.name), emitido el dia: \(dateFormatter.string(from: firstAired))"
        } else {
            return "Episodio: \(title), emitido el dia: \(dateFormatter.string(from: firstAired))"
        }
    }
}
