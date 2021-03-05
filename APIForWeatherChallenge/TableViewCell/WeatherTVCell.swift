//
//  WeatherTVCell.swift
//  APIForWeatherChallenge
//
//  Created by 董恩志 on 2021/2/23.
//

import UIKit

class WeatherTVCell: UITableViewCell {
    
    static let weatherCellID = "Cell"
    
    let cityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25)
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    let tempLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 45)
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    var weatherIcon: UIImageView = {
        let image = UIImageView()
        
        return image
    }()
    
    override func layoutSubviews() {
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        cityLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20).isActive = true
        cityLabel.bottomAnchor.constraint(equalTo: tempLabel.bottomAnchor).isActive = true
        
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        tempLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -10).isActive = true
        tempLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20).isActive = true
        timeLabel.topAnchor.constraint(equalTo: tempLabel.topAnchor).isActive = true
        
        weatherIcon.translatesAutoresizingMaskIntoConstraints = false
        weatherIcon.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        weatherIcon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
    
   
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(cityLabel)
        contentView.addSubview(tempLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(weatherIcon)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
