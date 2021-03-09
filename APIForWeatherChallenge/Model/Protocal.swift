//
//  Protocal.swift
//  APIForWeatherChallenge
//
//  Created by 董恩志 on 2021/2/24.
//

import Foundation


protocol SearchResult {
    func citySearch(city:String)
}


extension String {
    
    func urlEncoded() -> String {
        let encodeUrlString = self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        return encodeUrlString ?? ""
    }
}

extension Int {
    #warning("?")
    func timetransform() -> String {
        let timeInterval = TimeInterval(self)
        let date = Date(timeIntervalSince1970: timeInterval)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let currentTime = dateFormatter.string(from: date)
        return currentTime
    }
}

extension Double {
    
    var numberTransform: String {
        let newString = String(format: "%.0f", self)
        return newString
    }
}

enum tempTransform {
    case C,F
    
}
