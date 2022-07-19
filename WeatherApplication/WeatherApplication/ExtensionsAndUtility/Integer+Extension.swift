//
//  Integer+Extension.swift
//  WeatherApplication
//
//  Created by Bishwajit Dutta on 11/07/22.
//

import UIKit

// Extensions created for Int
extension Int {
    
    // This will give the date
    func changeEpochToLongDate() -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+5.30")
        dateFormatter.dateFormat = "EEEE, MMM dd, yyyy"
        return dateFormatter.string(from: date as Date)
    }
    
    // This will give the time
    func changeEpochToTime() -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+5.30")
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date as Date)
    }
}
