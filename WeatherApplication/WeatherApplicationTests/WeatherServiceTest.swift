//
//  WeatherServiceTest.swift
//  WeatherApplicationTests
//
//  Created by Bishwajit Dutta on 18/07/22.
//

import XCTest
@testable import WeatherApplication

class WeatherServiceTest: XCTestCase {

    var mockAPIHandler : MockAPIHandler?
    var testWeatherService : WeatherService?
    
    override func setUpWithError() throws {
        mockAPIHandler = MockAPIHandler()
        testWeatherService = WeatherService()
        testWeatherService?.apiHandler = mockAPIHandler
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        mockAPIHandler = nil
        testWeatherService = nil
    }
    
    
    func testCheckFailureErrorDataNilCurrentWeather() {
        mockAPIHandler?.checkWrongData = false
        testWeatherService?.getCurrentWeatherDataFor(city: "", completion: { response in
            switch response {
            case .Failure(let error):
                XCTAssertFalse(error.localizedDescription == "The operation couldn’t be completed.", "Miss match in error message")
                break
            case .Success(_):
                break
            }
        })
    }
    
    func testCheckFilureWrongDataErrorCurrentWeather() {
        mockAPIHandler?.checkWrongData = true
        testWeatherService?.getCurrentWeatherDataFor(city: "", completion: { response in
            switch response {
            case .Failure(let error):
                XCTAssertTrue(error.localizedDescription == "Data returned from server is nil.", "Miss match in error message")
                break
            case .Success(_):
                break
            }
        })
    }
    
    
    func testCheckFailureErrorDataNilWeatherDataForcast() {
        mockAPIHandler?.checkWrongData = false
        testWeatherService?.getWeatherDataForcastFor(city: "", completion: { response in
            switch response {
            case .Failure(let error):
                XCTAssertFalse(error.localizedDescription == "The operation couldn’t be completed.", "Miss match in error message")
                break
            case .Success(_):
                break
            }
        })
    }
    
    func testCheckFilureWrongDataErrorWeatherDataForcast() {
        mockAPIHandler?.checkWrongData = true
        testWeatherService?.getWeatherDataForcastFor(city: "", completion: { response in
            switch response {
            case .Failure(let error):
                XCTAssertTrue(error.localizedDescription == "The data couldn’t be read because it isn’t in the correct format.", "Miss match in error message")
                break
            case .Success(_):
                break
            }
        })
    }
    
}
