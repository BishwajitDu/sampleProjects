//
//  APIHandler.swift
//  WeatherApplication
//
//  Created by Bishwajit Dutta on 11/07/22.
//

import UIKit
import Foundation

// Added protocols for API class. Will have dependency injection
protocol WeatherAPI {
    func getWeatherDataForcastFor(city cityName: String, completion: @escaping (ResponseHandler<WeatherMasterData, WeatherAppError>) -> Void)
    func getCurrentWeatherDataFor(city cityName: String, completion: @escaping (ResponseHandler<WeatherData,WeatherAppError>) -> Void)
}


// Using file private access specifiers
fileprivate let hostUrl = "community-open-weather-map.p.rapidapi.com"

fileprivate let headers = ["X-RapidAPI-Key": "a2d7fd5f77msh7ce51ee15421e15p1114dbjsn5c67b1dffd35",
                     "X-RapidAPI-Host": hostUrl]

fileprivate let methodType = "GET"

fileprivate let session = URLSession.shared


// Use of Type alias to use as an error string
typealias ErrorString = String


// API Handler class
class APIHandler: WeatherAPI {
    
    private enum MethodName : String {
        case forecast       = "forecast"
        case currentWeather = "weather"
    }
    
    // Method to construct the Request for the API calls
    private func constructRequest(methodName: String, parameters : [URLQueryItem]) -> NSMutableURLRequest? {
        guard var urlComps = URLComponents(string: "https://\(hostUrl)/\(methodName)") else { return nil }
        urlComps.queryItems = parameters
        let request = NSMutableURLRequest(url: urlComps.url ?? NSURL(string:"")! as URL ,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = methodType
        request.allHTTPHeaderFields = headers
        return request
    }
    
    
    // This api call is for getting the forcast data on hourley basis
    func getWeatherDataForcastFor(city cityName: String, completion: @escaping (ResponseHandler<WeatherMasterData, WeatherAppError>) -> Void) {
        // Need to make the API call
        if let request = constructRequest(methodName: MethodName.forecast.rawValue, parameters: [URLQueryItem(name: "q", value: cityName)]) {
            let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
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
            task.resume()
        }
    }
    
    // This API call is for getting current data
    func getCurrentWeatherDataFor(city cityName: String, completion: @escaping (ResponseHandler<WeatherData,WeatherAppError>) -> Void) {
        let parameters = [URLQueryItem(name: "q", value: cityName),
                          URLQueryItem(name: "lang", value: "en"),
                          URLQueryItem(name: "units", value: "imperial")]
        if let request = constructRequest(methodName: MethodName.currentWeather.rawValue, parameters: parameters) {
            let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
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
            task.resume()
        }
    }
}
