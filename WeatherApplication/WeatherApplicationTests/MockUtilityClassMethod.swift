//
//  MockUtilityClassMethod.swift
//  WeatherApplicationTests
//
//  Created by Bishwajit Dutta on 12/07/22.
//

import UIKit
@testable import WeatherApplication

class MockUtilityClassMethod: UtilityProtocol {
    // This is needed because there is a logic to filter out the data
    func getTodayDate() -> String {
        return "2022-07-11"
    }
}
