//
//  Date.swift
//  Podcast
//
//  Created by MARC on 5/6/20.
//  Copyright © 2020 MARC. All rights reserved.
//

import Foundation

extension Date {
    func getDate() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = .current
        return dateFormatter.string(from: self)
    }
}
