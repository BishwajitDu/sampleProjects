//
//  WeatherDashboardViewModelTest.swift
//  WeatherApplicationTests
//
//  Created by Bishwajit Dutta on 12/07/22.
//

import XCTest
@testable import WeatherApplication

class WeatherDashboardViewModelTest: XCTestCase {

    var testViewModel : WeatherDashboardViewModel?
    var mockAPI : MockAPIHandler?
    
    override func setUpWithError() throws {
        testViewModel = WeatherDashboardViewModel(cityName: "")
        mockAPI = MockAPIHandler()
    }

    override func tearDownWithError() throws {
        testViewModel = nil
    }
    
    func testfetchCurrentWeatherFromAPISuccess() {
        mockAPI?.checkforSuccess = true
        testViewModel?.apiHandler = mockAPI
        testViewModel?.fetchCurrentWeatherFromAPI()
        XCTAssertNotNil(testViewModel?.weatherData, "The value is nil")
        XCTAssertTrue(testViewModel?.weatherData?.dateTime == 1657554972, "Date time value miss match")
        XCTAssertTrue(testViewModel?.weatherData?.locationName == "Kolkata", "location name miss match")
    }
    
    func testfetchCurrentWeatherFromAPIFailure() {
        mockAPI?.checkforSuccess = false
        testViewModel?.apiHandler = mockAPI
        testViewModel?.fetchCurrentWeatherFromAPI()
        XCTAssertNil(testViewModel?.weatherData, "The value is not nil")
        XCTAssertFalse(testViewModel?.weatherData?.dateTime == 1657554972, "Date time value miss match")
        XCTAssertFalse(testViewModel?.weatherData?.locationName == "Kolkata", "location name miss match")
    }
    
    func testfetchMasterWeatherDataFromAPISuccess() {
        mockAPI?.checkforSuccess = true
        testViewModel?.apiHandler = mockAPI
        testViewModel?.fetchMasterWeatherDataFromAPI()
        XCTAssertNotNil(testViewModel?.weatherMasterData, "The value is nil")
        XCTAssertTrue(testViewModel?.weatherMasterData?.cnt == 40, "count miss match")
        XCTAssertNil(testViewModel?.weatherMasterData?.list?.first?.locationName, "The value is not nil")
    }
    
    func testfetchMasterWeatherDataFromAPIFailure() {
        mockAPI?.checkforSuccess = false
        testViewModel?.apiHandler = mockAPI
        testViewModel?.fetchMasterWeatherDataFromAPI()
        XCTAssertNil(testViewModel?.weatherMasterData, "The value is not nil")
        XCTAssertFalse(testViewModel?.weatherMasterData?.cnt == 40, "count miss match")
    }

}
