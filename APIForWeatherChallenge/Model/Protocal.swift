//
//  Protocal.swift
//  APIForWeatherChallenge
//
//  Created by 董恩志 on 2021/2/24.
//

import UIKit

protocol SearchResult {
    func citySearch(city:String,searchRecord:[String])
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

extension UIView {
    
    func setGradientLayer() {
        let color1 = UIColor.systemBlue.cgColor
        let color2 = UIColor.systemYellow.cgColor
        let fullSize = UIScreen.main.bounds
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = frame(forAlignmentRect: CGRect(x: 0, y: 0, width: fullSize.width, height: fullSize.height))
        gradientLayer.colors = [color1, color2]
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
}

