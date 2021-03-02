//
//  CitySearchMode.swift
//  APIForWeatherChallenge
//
//  Created by 董恩志 on 2021/2/25.
//

import Foundation

// MARK: - CityAPI
struct CityAPI: Codable {
    let results: [Result]
}

// MARK: - Result
struct Result: Codable {
    let objectID, name, createdAt, updatedAt: String
    let languages, cities, timezones, provinces: Cities

    enum CodingKeys: String, CodingKey {
        case objectID = "objectId"
        case name, createdAt, updatedAt, languages, cities, timezones, provinces
    }
}

// MARK: - Cities
struct Cities: Codable {
    let type, className: String

    enum CodingKeys: String, CodingKey {
        case type = "__type"
        case className
    }
}
