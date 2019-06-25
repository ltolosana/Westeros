//
//  String+toDate.swift
//  Westeros
//
//  Created by Luis Maria Tolosana Simon on 25/06/2019.
//  Copyright © 2019 Luis Maria Tolosana Simon. All rights reserved.
//

import Foundation

extension String {
    func toDate() -> Date {
        let dateStringFormatter = DateFormatter()
        dateStringFormatter.dateFormat = "dd/MM/yyyy"
        //        dateStringFormatter.locale = Locale(identifier: "es_ES")
        //        dateStringFormatter.timeZone = TimeZone.current
        guard let dateFromString = dateStringFormatter.date(from: self)
            else { return Date() }
        print(dateFromString)
        return dateFromString
    }
}
