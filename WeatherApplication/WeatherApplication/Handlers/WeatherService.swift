//
//  WeatherService.swift
//  WeatherApplication
//
//  Created by Bishwajit Dutta on 18/07/22.
//

import UIKit

class WeatherService: WeatherAPI {
    // Method names for WeatherAPI
    private enum MethodName : String {
        case forecast       = "forecast"
        case currentWeather = "weather"
    }
    
    // API handler object
    var apiHandler : APIHandlerProtocol?
    
    init() {
        apiHandler = APIHandler()
    }
    
    // This api call is for getting the forcast data on hourley basis
    func getWeatherDataForcastFor(city cityName: String, completion: @escaping (ResponseHandler<WeatherMasterData, WeatherAppError>) -> Void) {
        apiHandler?.makeAPICall(methodname: MethodName.forecast.rawValue, withParameters: [URLQueryItem(name: "q", value: cityName)], methodType: APIMethodType.GET) { (data, response, error) in
            if error != nil {
                let appError = WeatherAppError()
                appError.localizedDescription = error?.localizedDescription ?? ""
                completion(.Failure(appError))
                return
            }
            if data == nil {
                completion(.Failure(WeatherAppError()))
                return
            }
            do {
                let weatherData = try JSONDecoder().decode(WeatherMasterData.self, from: data!)
                completion(.Success(weatherData))
            } catch let error {
                let appError = WeatherAppError()
                appError.localizedDescription = error.localizedDescription
                completion(.Failure(appError))
            }
        }
    }
    
    // This API call is for getting current data
    func getCurrentWeatherDataFor(city cityName: String, completion: @escaping (ResponseHandler<WeatherData, WeatherAppError>) -> Void) {
        let parameters = [URLQueryItem(name: "q", value: cityName),
                          URLQueryItem(name: "lang", value: "en"),
                          URLQueryItem(name: "units", value: "imperial")]
        apiHandler?.makeAPICall(methodname: MethodName.currentWeather.rawValue, withParameters: parameters, methodType: APIMethodType.GET) { (data, response, error) in
            if error != nil {
                let appError = WeatherAppError()
                appError.localizedDescription = error?.localizedDescription ?? ""
                completion(.Failure(appError))
                return
            }
            if data == nil {
                completion(.Failure(WeatherAppError()))
                return
            }
            do {
                let weatherData = try JSONDecoder().decode(WeatherData.self, from: data!)
                completion(.Success(weatherData))
            } catch let error {
                let appError = WeatherAppError()
                appError.localizedDescription = error.localizedDescription
            }
        }
    }
}
