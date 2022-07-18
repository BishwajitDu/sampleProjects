//
//  APIProtocols.swift
//  WeatherApplication
//
//  Created by Bishwajit Dutta on 18/07/22.
//

import Foundation

// Protocol added for API handler
protocol APIHandlerProtocol {
    func makeAPICall(methodname name:String, withParameters parms:[URLQueryItem], methodType: APIMethodType, completion: @escaping (Data?, URLResponse?, Error?) -> Void)
}


// Added protocols for API class. Will have dependency injection
protocol WeatherAPI {
    func getWeatherDataForcastFor(city cityName: String, completion: @escaping (ResponseHandler<WeatherMasterData, WeatherAppError>) -> Void)
    func getCurrentWeatherDataFor(city cityName: String, completion: @escaping (ResponseHandler<WeatherData,WeatherAppError>) -> Void)
}

