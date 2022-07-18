//
//  Constants.swift
//  WeatherApplication
//
//  Created by Bishwajit Dutta on 12/07/22.
//

import UIKit

// Few Constants and Magic numbers
class Constants: NSObject {
    // value = 15.0
    static let edgeOffSet       : CGFloat = (UIScreen.main.bounds.width * 0.038).rounded()
    // value = 20.0
    static let verticalOffSet   : CGFloat = (UIScreen.main.bounds.height * 0.024).rounded()
    // value = 10.0
    static let interElementOffSet   : CGFloat = (UIScreen.main.bounds.height * 0.012).rounded()
    static let headerTextViewOffset   : CGFloat = 100.0
    static let placeSelectionHeader : String = NSLocalizedString("PlaceSelectionHeader", comment: "")
    static let hostUrl : String = "community-open-weather-map.p.rapidapi.com"
    static let rapidApiKey : String = "X-RapidAPI-Key"
    static let apiKey : String = "a2d7fd5f77msh7ce51ee15421e15p1114dbjsn5c67b1dffd35"
    static let rapidAPiHostKey : String = "X-RapidAPI-Host"
    static let additionalDetailsCell : String = "AdditionalDetailsCell"
    static let cityNameDisplayCell : String = "CityNameDisplayCell"
    static let dashboardControllerName : String = "DashboardViewController"
    static let mainStoryboard : String = "Main"
    static let dataReturnNilMessage : String = "Data returned from server is nil."
    static let cityListPlistName : String = "CityList"
}
