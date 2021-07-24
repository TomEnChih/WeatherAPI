//
//  WeatherMode.swift
//  APIForWeatherChallenge
//
//  Created by 董恩志 on 2021/2/18.
//

import Foundation

struct WeatherData:Decodable {
    var name: String
    var id: Int
    var dt: Int
    var coord: Coord
    var main: Main
    var sys: Sys
    var weather: [Weather]
    var wind: Wind
}


struct Coord:Decodable {
    var lon: Double
    var lat: Double
}

struct Main:Decodable {
    var temp: Double
    var humidity: Int
    var temp_min: Double
    var temp_max: Double
    var feels_like: Double
}

struct Weather: Decodable {
    var icon: String
    var main: String
    var description: String
}

struct Sys: Codable {
    let type, id: Int
    let country: String
    let sunrise, sunset: Int
}

struct Wind: Codable {
    let speed: Double
}
