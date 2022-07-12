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
}
