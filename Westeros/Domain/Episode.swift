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
    
    init(title: String, firstAired: Date, season: Season) {
        self.title = title
        self.firstAired = firstAired
        self.season = season
    }
    
}
