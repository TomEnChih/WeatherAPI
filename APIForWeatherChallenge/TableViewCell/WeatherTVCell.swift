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
        label.font = UIFont.systemFont(ofSize: 35)
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    let tempLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 60)
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        label.textAlignment = NSTextAlignment.center
//        label.numberOfLines = 0
        return label
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25)
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    var weatherIcon: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return image
    }()
    
    
    func setupUI() {
        let labelStackView = UIStackView(arrangedSubviews: [timeLabel, cityLabel])
        labelStackView.axis = .vertical
        labelStackView.alignment = .leading
        labelStackView.spacing = 4
        let mainStackView = UIStackView(arrangedSubviews: [labelStackView, weatherIcon, tempLabel])
        mainStackView.axis = .horizontal
        mainStackView.distribution = .equalSpacing
        contentView.addSubview(mainStackView)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
//    func testLayout() {
//        //城市
//        cityLabel.translatesAutoresizingMaskIntoConstraints = false
//        cityLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20).isActive = true
//        cityLabel.bottomAnchor.constraint(equalTo: tempLabel.bottomAnchor).isActive = true
//        //溫度
//        tempLabel.translatesAutoresizingMaskIntoConstraints = false
//        tempLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -10).isActive = true
//        tempLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
//        //時刻
//        timeLabel.translatesAutoresizingMaskIntoConstraints = false
//        timeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20).isActive = true
//        timeLabel.topAnchor.constraint(equalTo: tempLabel.topAnchor).isActive = true
//        //天氣圖
//        weatherIcon.translatesAutoresizingMaskIntoConstraints = false
//        weatherIcon.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
//        weatherIcon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
//        weatherIcon.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
//        weatherIcon.topAnchor.constraint(equalTo: contentView.topAnchor,constant: -10).isActive = true
//    }
   
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        contentView.addSubview(cityLabel)
//        contentView.addSubview(tempLabel)
//        contentView.addSubview(timeLabel)
//        contentView.addSubview(weatherIcon)
//        testLayout()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
