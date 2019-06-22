//
//  Date+FromString.swift
//  Westeros
//
//  Created by Luis Maria Tolosana Simon on 22/06/2019.
//  Copyright © 2019 Luis Maria Tolosana Simon. All rights reserved.
//

import Foundation

extension Date {
    
    func fromString(_ dateString: String) -> Date {
        let dateStringFormatter = DateFormatter()
        dateStringFormatter.dateFormat = "dd/MM/yyyy"
        guard let dateFromString = dateStringFormatter.date(from: dateString) else { return Date() }
        return dateFromString
    }
}

