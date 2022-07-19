//
//  AdditionalDetailsCellTest.swift
//  WeatherApplicationTests
//
//  Created by Bishwajit Dutta on 19/07/22.
//

import XCTest
@testable import WeatherApplication

class AdditionalDetailsCellTest: XCTestCase {

    var testAdditionalCellData : AdditionalDetailsCell?
    
    override func setUpWithError() throws {
        testAdditionalCellData = AdditionalDetailsCell()
    }

    override func tearDownWithError() throws {
        testAdditionalCellData = nil
    }
    
    func testDataBindingInCell() {
        testAdditionalCellData?.bindData(time: "hhe", humidity: 12.0, temp: 11.3, icon: "")
        XCTAssertTrue(testAdditionalCellData?.timeLbl.text == "hhe", "Miss match in time value")
        XCTAssertTrue(testAdditionalCellData?.humidityLbl.text == "12.0 %", "Miss match in humidity value")
        XCTAssertTrue(testAdditionalCellData?.temperatureLbl.text == "11.3 °K", "Miss match in temparature value")
    }
    
    
    func testDataBindingInCellNil() {
        testAdditionalCellData?.bindData(time: nil, humidity: nil, temp: nil, icon: nil)
        XCTAssertTrue(testAdditionalCellData?.timeLbl.text == "00:00", "Miss match in time value")
        XCTAssertTrue(testAdditionalCellData?.humidityLbl.text == "0.0 %", "Miss match in humidity value")
        XCTAssertTrue(testAdditionalCellData?.temperatureLbl.text == "0.0 °K", "Miss match in temparature value")
    }

}
