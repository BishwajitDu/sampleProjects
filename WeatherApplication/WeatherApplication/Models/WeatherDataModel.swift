//
//  WeatherDataModel.swift
//  WeatherApplication
//
//  Created by Bishwajit Dutta on 11/07/22.
//

import UIKit

// This is the parent node for getting the weather data
struct WeatherMasterData : Codable {
    var cnt: Int?
    var list: [WeatherData]?
    var city: CityDetails?
    
    enum CodingKeys: String, CodingKey {
        case cnt
        case list
        case city
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        cnt           = try? container.decode(Int.self, forKey: .cnt)
        list          = try? container.decode([WeatherData].self, forKey: .list)
        city          = try? container.decode(CityDetails.self, forKey: .city)
    }
}

// This is node for weather data hourly basis ( currently 3 hrs )
struct WeatherData : Codable {
    var dateTime : Int?
    var additionalWeatherData: AdditionalWeatherInfo?
    var weatherType: [WeatherType]?
    var windData: WindData?
    var dateTimeText: String?
    var locationName: String?
    
    enum CodingKeys: String, CodingKey {
        case dateTime = "dt"
        case additionalWeatherData = "main"
        case weatherType = "weather"
        case windData = "wind"
        case dateTimeText = "dt_txt"
        case locationName = "name"
    }
    
    init(from decoder: Decoder) throws {
        let container          = try decoder.container(keyedBy: CodingKeys.self)
        dateTime               = try? container.decode(Int.self, forKey: .dateTime)
        additionalWeatherData  = try? container.decode(AdditionalWeatherInfo.self, forKey: .additionalWeatherData)
        weatherType            = try? container.decode([WeatherType].self, forKey: .weatherType)
        windData               = try? container.decode(WindData.self, forKey: .windData)
        dateTimeText           = try? container.decode(String.self, forKey: .dateTimeText)
        locationName           = try? container.decode(String.self, forKey: .locationName)
    }
}

// Additional weather information for 3 hrs
struct AdditionalWeatherInfo : Codable {
    var temp : Float?
    var feelsLike : Float?
    var maxTemp: Float?
    var minTemp: Float?
    var humidity: Float?
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case maxTemp   = "temp_max"
        case minTemp   = "temp_min"
        case humidity
    }
}

// Weather type for the 3 hrs window
struct WeatherType : Codable {
    var id : Int?
    var type : String?
    var description: String?
    var icon : String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case type = "main"
        case description
        case icon
    }
}

// Wind Data for the 3 hrs window
struct WindData : Codable {
    var speed : Float?
    var degree : Float?
    var gusting: Float?
    
    enum CodingKeys: String, CodingKey {
        case speed
        case degree = "deg"
        case gusting = "gust"
    }
}

// City related information from the json Data
struct CityDetails: Codable {
    var id : Int?
    var name: String?
    var country: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case country
    }
}
