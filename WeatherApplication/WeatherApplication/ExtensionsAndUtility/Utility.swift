//
//  Utility.swift
//  WeatherApplication
//
//  Created by Bishwajit Dutta on 12/07/22.
//

import UIKit

@objc protocol UtilityProtocol {
    func getTodayDate() -> String
}

class Utility: UtilityProtocol {
    
    func getTodayDate() -> String {
        // Get Todays date
        let todaysDate = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: todaysDate as Date)
    }
}
