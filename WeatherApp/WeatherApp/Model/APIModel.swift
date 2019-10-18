//
//  APIModel.swift
//  WeatherApp
//
//  Created by EricM on 10/10/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import Foundation


//PIXA-------------------------------------------------------------------------

struct Total: Codable {
    let hits: [Hits]
}

struct Hits: Codable {
    let largeImageURL: String
    let tags: String
    let likes: Int
}
//MARK: Zipcode Locality
struct City: Codable{
    var city: String
    let skyInfo: Sky
}
//Sky----------------------------------------------------------------------------
struct Sky: Codable{
    let latitude, longitude : Double
    let daily: Daily
}

struct Daily: Codable {
    let data: [DailyData]
}

struct DailyData: Codable {
    let time: Int
    let sunriseTime, sunsetTime: Int
    let windGust: Double
    let temperatureLow: Double
    let temperatureHigh: Double
    let summary: String
    let icon: String
}

//enum Icon: String, Codable, CodingKey {
//case clearDay = "clear-day"
//case clearNight = "clear-night"
//case cloudy = "cloudy"
//case partlyCloudyDay = "partly-cloudy-day"
//case partlyCloudyNight = "partly-cloudy-night"
//case rain = "rain"
//}

struct Favorite: Codable {
    //let name: String
    let image: Data
}
