//
//  Season.swift
//  Westeros
//
//  Created by Luis Maria Tolosana Simon on 22/06/2019.
//  Copyright © 2019 Luis Maria Tolosana Simon. All rights reserved.
//

import Foundation

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
}
