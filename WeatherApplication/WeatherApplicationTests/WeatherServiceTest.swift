//
//  WeatherServiceTest.swift
//  WeatherApplicationTests
//
//  Created by Bishwajit Dutta on 18/07/22.
//

import XCTest
@testable import WeatherApplication

class WeatherServiceTest: XCTestCase {

    var mockAPIHandler : APIHandlerProtocol?
    var testWeatherService : WeatherService?
    
    override func setUpWithError() throws {
        mockAPIHandler = MockAPIHandler()
        self.testWeatherService = WeatherService()
        testWeatherService?.apiHandler = mockAPIHandler
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        mockAPIHandler = nil
        testWeatherService = nil
    }
}
