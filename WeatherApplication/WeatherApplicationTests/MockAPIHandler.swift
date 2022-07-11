//
//  MockAPIHandler.swift
//  WeatherApplicationTests
//
//  Created by Bishwajit Dutta on 12/07/22.
//

import UIKit
@testable import WeatherApplication

class MockAPIHandler: WeatherAPI {
    
    var checkforSuccess : Bool = true
    
    func getWeatherDataForcastFor(city cityName: String, completion: @escaping (ResponseHandler<WeatherMasterData, WeatherAppError>) -> Void) {
        if checkforSuccess {
            if let path = Bundle(for: MockAPIHandler.self).path(forResource: "mockData", ofType: "json") {
                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                    let response = try JSONDecoder().decode(WeatherMasterData.self, from: data)
                    completion(.Success(response))
                } catch let error {
                    print(" error \(error.localizedDescription)")
                }
                return
            }
        }
        completion(.Failure(WeatherAppError()))
    }
    
    func getCurrentWeatherDataFor(city cityName: String, completion: @escaping (ResponseHandler<WeatherData, WeatherAppError>) -> Void) {
        if checkforSuccess {
            if let path = Bundle(for: MockAPIHandler.self).path(forResource: "mockCurrectWeather", ofType: "json") {
                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                    let response = try JSONDecoder().decode(WeatherData.self, from: data)
                    completion(.Success(response))
                } catch let error {
                    print(" error \(error.localizedDescription)")
                }
            }
            return
        }
        completion(.Failure(WeatherAppError()))
    }
}
