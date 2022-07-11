//
//  WeatherDashboardViewModel.swift
//  WeatherApplication
//
//  Created by Bishwajit Dutta on 11/07/22.
//

import UIKit

// Using semaphore to notify the operations are complete
let weatherDashboardSemaphore = DispatchSemaphore(value: 1)

class WeatherDashboardViewModel: NSObject {
    
    private(set) var weatherMasterData  : WeatherMasterData?
    private(set) var weatherData        : WeatherData?
    private(set) var filteredMasterData : WeatherMasterData?
    private(set) var cityName           : String?
    private(set) var errorMessage       : String?
    var apiHandler                      : WeatherAPI?
    var utilityClass                    : UtilityProtocol?
    
    init(cityName: String) {
        self.cityName = cityName
        apiHandler = APIHandler()
        utilityClass = Utility()
    }
    
    
    // This method is called to fetch the current weather data for a location
    func fetchCurrentWeatherFromAPI() {
        weatherDashboardSemaphore.wait()
        apiHandler?.getCurrentWeatherDataFor(city: self.cityName ?? "", completion: { [weak self] response in
            guard let strongSelf = self else {return}
            switch response {
            case .Success(let data):
                strongSelf.weatherData = data
                weatherDashboardSemaphore.signal()
                break
            case .Failure(let error):
                // Need to how alert of any notification to user
                print(error.localizedDescription)
                strongSelf.errorMessage = error.localizedDescription
                weatherDashboardSemaphore.signal()
                break
            }
        })
    }
    
    // This method is called to fetch master weather data
    func fetchMasterWeatherDataFromAPI() {
        weatherDashboardSemaphore.wait()
        apiHandler?.getWeatherDataForcastFor(city: self.cityName ?? "", completion: { [weak self] response in
            guard let strongSelf = self else {return}
            switch response {
            case .Success(let data):
                strongSelf.weatherMasterData = data
                strongSelf.filterMasterDataWithDate(todayDate: strongSelf.utilityClass?.getTodayDate() ?? "")
                break
            case .Failure(let error):
                // Need to how alert of any notification to user
                print(error.localizedDescription)
                strongSelf.errorMessage = error.localizedDescription
                weatherDashboardSemaphore.signal()
                break
            }
        })
    }
    
    
    
    private func filterMasterDataWithDate(todayDate : String) {
        // Filter the data for current date
        if let list = weatherMasterData?.list, list.count > 0 {
            let filteredList = list.filter({($0.dateTimeText?.split(separator: " ").map({ String($0)}))?.first ==  todayDate})
            self.weatherMasterData?.list = filteredList
        }
        weatherDashboardSemaphore.signal()
    }
}
