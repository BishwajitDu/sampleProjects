//
//  MockPlaceSelectionViewModel.swift
//  WeatherApplicationTests
//
//  Created by Bishwajit Dutta on 12/07/22.
//

import UIKit
@testable import WeatherApplication

class MockPlaceSelectionViewModel: PlaceSelectionViewModelProtocol {
    
    var checkForCityListZero : Bool = false
    
    func screenTitle() -> String {
        return "This text is from Mock data"
    }
    
    func fetchCityList() -> [String] {
        if checkForCityListZero { return [] }
        return ["Madrid,Spain","Brussels,Belgium","Beijing,China","Tokyo,Japan","Paris,France"]
    }
}
