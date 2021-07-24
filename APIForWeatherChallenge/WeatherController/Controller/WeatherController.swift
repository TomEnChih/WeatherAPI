//
//  WeatherController.swift
//  APIForWeatherChallenge
//
//  Created by 董恩志 on 2021/7/22.
//

import UIKit

class WeatherController: UIViewController {
    // MARK: - Properties
    
    private let weatherView = WeatherView()
    
    private var data: WeatherData
    
    // MARK: - Init
    
    init(data: WeatherData) {
        self.data = data
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = weatherView
        setNavigationItem()
        setView()
    }
    
    // MARK: - Methods
    
    private func setNavigationItem() {
        navigationItem.title = data.name
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
    }
    
    private func setView() {
        
        let url = URL(string: "http://openweathermap.org/img/wn/\(data.weather[0].icon)@2x.png")
        let image = try? Data(contentsOf: url!)
        if let imageData = image {
            let image = UIImage(data: imageData)
            weatherView.weatherIcon.image = image
        }
        
        weatherView.tempLabel.text = String(data.main.temp.numberTransform)+"°C"
        weatherView.tempMaxLabel.setText(String1: "TempMax", String2: String(data.main.temp_max.numberTransform)+"°C")
        weatherView.tempMinLabel.setText(String1: "TempMin", String2: String(data.main.temp_min.numberTransform)+"°C")
        weatherView.tempHumanFeelLabel.setText(String1: "TempHumanFeel", String2: String(data.main.feels_like.numberTransform)+"°C")
        weatherView.sunriseLabel.setText(String1: "Sunrise", String2: data.sys.sunrise.timetransform())
        weatherView.sunsetLabel.setText(String1: "Sunrise", String2: data.sys.sunset.timetransform())
        weatherView.windSpeedLabel.setText(String1: "WindSpeed", String2: String(data.wind.speed))
        
    }
    
    
}



extension UILabel {
    
    func setText(String1: String, String2: String){
        //applying the line break mode
        self.lineBreakMode = NSLineBreakMode.byWordWrapping;
        let text: NSString = "\(String1)\n\(String2)" as NSString
        
        //getting the range to separate the button title strings
        let newlineRange: NSRange = text.range(of: "\n")
        
        //getting both substrings 為了分成兩個String
        var substring1 = ""
        var substring2 = ""
        
        if(newlineRange.location != NSNotFound) {
            substring1 = text.substring(to: newlineRange.location)
            substring2 = text.substring(from: newlineRange.location)
        }
        
        //assigning diffrent fonts to both substrings
        let font1: UIFont = UIFont.italicSystemFont(ofSize: 15)
        let attributes1 = [NSMutableAttributedString.Key.font: font1,NSMutableAttributedString.Key.foregroundColor:UIColor.lightGray]
        let attrString1 = NSMutableAttributedString(string: substring1, attributes: attributes1)
        
        let font2: UIFont = UIFont.boldSystemFont(ofSize: 30)
        let attributes2 = [NSMutableAttributedString.Key.font: font2,NSMutableAttributedString.Key.foregroundColor:UIColor.black]
        let attrString2 = NSMutableAttributedString(string: substring2, attributes: attributes2)
        
        attrString1.append(attrString2)
        
        self.attributedText = attrString1
    }
}
