//
//  PlaceSelectionViewModel.swift
//  WeatherApplication
//
//  Created by Bishwajit Dutta on 11/07/22.
//

import UIKit

// Protocol added for place selection
protocol PlaceSelectionViewModelProtocol {
    func screenTitle() -> String
    func fetchCityList() -> [String]
}

class PlaceSelectionViewModel: PlaceSelectionViewModelProtocol {

    // Setting the title of the screen
    func screenTitle() -> String {
        return Constants.placeSelectionHeader
    }
    
    // Fetching city list from plist file
    func fetchCityList() -> [String] {
        if let path = Bundle.main.path(forResource: Constants.cityListPlistName, ofType: "plist"),
           let data = FileManager.default.contents(atPath: path){
            let plistData = try? PropertyListSerialization.propertyList(from: data, options: .mutableContainersAndLeaves, format: nil)
            return (plistData) as? [String] ?? [""]
        }
        return [""]
    }
}
