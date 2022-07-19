//
//  ImageExtensionTest.swift
//  WeatherApplicationTests
//
//  Created by Bishwajit Dutta on 19/07/22.
//

import XCTest
@testable import WeatherApplication

class ImageExtensionTest: XCTestCase {

    let testEpochTime = 1658228381
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testIntegerLongDateExtension() {
        XCTAssertTrue(testEpochTime.changeEpochToLongDate() == "Tuesday, Jul 19, 2022", "Miss match in date coversion")
    }

    func testIntegerShortDateExtension() {
        XCTAssertTrue(testEpochTime.changeEpochToTime() == "16:29", "Miss match in time coversion")
    }
}
