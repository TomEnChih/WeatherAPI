//
//  CitySearchMode.swift
//  APIForWeatherChallenge
//
//  Created by 董恩志 on 2021/2/25.
//

import Foundation

// MARK: - CityAPI
struct City: Codable {
    let countryName: String

    enum CodingKeys: String, CodingKey {
        case countryName = "country_name"
    }
}

typealias CityAPI = [City]

