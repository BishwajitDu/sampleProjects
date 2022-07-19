//
//  DashboardViewControllerTest.swift
//  WeatherApplicationTests
//
//  Created by Bishwajit Dutta on 12/07/22.
//

import XCTest
@testable import WeatherApplication

class DashboardViewControllerTest: XCTestCase {

    var testController : DashboardViewController?
    var testViewModel : WeatherDashboardViewModel?
    var mockAPI : MockWeatherService?
    var mockUtility : MockUtilityClassMethod?
    
    override func setUpWithError() throws {
        testController = DashboardViewController()
        testViewModel = WeatherDashboardViewModel(cityName: "")
        mockAPI = MockWeatherService()
        mockUtility = MockUtilityClassMethod()
        testViewModel?.utilityClass = mockUtility
    }

    override func tearDownWithError() throws {
        testController = nil
        testViewModel = nil
        mockAPI = nil
        mockUtility = nil
    }
    
    func testAPIErrorMessage() {
        mockAPI?.checkforSuccess = false
        testViewModel?.weatherService = mockAPI
        testController?.viewModel = testViewModel
        testController?.fetchData()
        XCTAssertTrue(testController?.apiErrorMessage == "Data returned from server is nil.", "Miss match in error message")
    }
    
    func testCurrentWeatherDetails() {
        mockAPI?.checkforSuccess = true
        testViewModel?.weatherService = mockAPI
        testController?.viewModel = testViewModel
        testController?.fetchData()
        XCTAssertTrue(testController?.weatherData?.locationName == "Kolkata","Miss match in place name")
        XCTAssertTrue(testController?.weatherData?.dateTime == 1657554972,"Miss match in date time")
        XCTAssertTrue(testController?.weatherData?.weatherType?.first?.type == "Haze","Miss match in weather type")
        XCTAssertTrue(testController?.weatherData?.additionalWeatherData?.temp == 84.15,"Miss match in additional information temperature")
    }
    
    func testadditionalWeatherDetails() {
        mockAPI?.checkforSuccess = true
        testViewModel?.weatherService = mockAPI
        testController?.viewModel = testViewModel
        testController?.fetchData()
        XCTAssertTrue(testController?.additionalWeatherData?.list?.first?.additionalWeatherData?.humidity == 64,"Miss match in humidity")
        XCTAssertTrue(testController?.additionalWeatherData?.list?.first?.additionalWeatherData?.temp == 305.98,"Miss match in additional information temperature")
        XCTAssertTrue(testController?.additionalWeatherData?.list?.first?.additionalWeatherData?.minTemp == 305.71,"Miss match in additional information minimum temperature")
    }
    
    func testDashboardControllerInitiallize() {
        let vm = DashboardViewController.getDashboardViewController(withViewModel: testViewModel!)
        XCTAssertTrue(((vm?.isKind(of: DashboardViewController.self)) != nil),"Miss match in controller")
    }

}
