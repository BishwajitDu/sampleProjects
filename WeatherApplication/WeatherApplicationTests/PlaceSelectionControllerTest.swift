//
//  PlaceSelectionControllerTest.swift
//  WeatherApplicationTests
//
//  Created by Bishwajit Dutta on 12/07/22.
//

import XCTest
@testable import WeatherApplication

class PlaceSelectionControllerTest: XCTestCase {

    var testController : PlaceSelectionViewController?
    var mockVM : MockPlaceSelectionViewModel?
    
    override func setUpWithError() throws {
        testController = PlaceSelectionViewController()
        mockVM = MockPlaceSelectionViewModel()
    }

    override func tearDownWithError() throws {
        testController = nil
        mockVM = nil
    }

    func testCityListCountZero() {
        mockVM?.checkForCityListZero = true
        testController?.viewModel = mockVM
        testController?.fetchData()
        XCTAssertEqual(testController?.cityListArr.count, 0, "City list should be zero")
    }
    
    
    func testCityListCountShowsAll() {
        mockVM?.checkForCityListZero = false
        testController?.viewModel = mockVM
        testController?.fetchData()
        XCTAssertTrue(testController?.cityListArr.count == 5, "City list count mismatch")
    }
    
    func testScreenTitle() {
        testController?.viewModel = mockVM
        testController?.fetchData()
        XCTAssertTrue(testController?.titleLbl.text == "This text is from Mock data", "Text miss match")
    }
    
    func testDataItemInCityList() {
        mockVM?.checkForCityListZero = false
        testController?.viewModel = mockVM
        testController?.fetchData()
        XCTAssertTrue(testController?.cityListArr[2] == "Beijing,China", "City list item miss match")
    }

}
