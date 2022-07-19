//
//  CityNameDisplayCellTest.swift
//  WeatherApplicationTests
//
//  Created by Bishwajit Dutta on 19/07/22.
//

import XCTest
@testable import WeatherApplication

class CityNameDisplayCellTest: XCTestCase {

    var testCityNameDisplayCell : CityNameDisplayCell?
    
    override func setUpWithError() throws {
        testCityNameDisplayCell = CityNameDisplayCell()
    }

    override func tearDownWithError() throws {
        testCityNameDisplayCell = nil
    }
    
    func testDataBindingInCell() {
        testCityNameDisplayCell?.bindData(name: "Hello, World")
        XCTAssertTrue(testCityNameDisplayCell?.cityNameLbl.text == "Hello", "Miss match in cityName value")
        XCTAssertTrue(testCityNameDisplayCell?.countryNameLbl.text == " World", "Miss match in cityName value")
    }
    
    func testDataBindingInCellError() {
        testCityNameDisplayCell?.bindData(name: ",")
        XCTAssertTrue(testCityNameDisplayCell?.cityNameLbl.text == "", "Miss match in cityName value")
        XCTAssertTrue(testCityNameDisplayCell?.countryNameLbl.text == "", "Miss match in cityName value")
    }

}
