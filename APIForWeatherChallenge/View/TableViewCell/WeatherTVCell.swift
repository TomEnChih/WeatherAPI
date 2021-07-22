//
//  WeatherTVCell.swift
//  APIForWeatherChallenge
//
//  Created by 董恩志 on 2021/2/23.
//

import UIKit

class WeatherTVCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let id = "Cell"
    
    // MARK: - IBElements
    
    let cityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 50)
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
//        label.backgroundColor = .blue
//        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    let tempLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 50)
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
//        label.backgroundColor = .yellow
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
//        label.backgroundColor = .green
//        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    var weatherIcon: UIImageView = {
        let image = UIImageView()
//        image.backgroundColor = .darkGray
        return image
    }()
    
    let customBackgroundView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8.0
        view.layer.borderColor = UIColor.secondaryLabel.cgColor
        return view
    }()
    
    // MARK: - Autolayout
    
    func autoLayout() {
        
        customBackgroundView.snp.makeConstraints { (make) in
            make.top.left.equalTo(self).offset(10)
            make.bottom.right.equalTo(self).offset(-10)
        }
        
        cityLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(customBackgroundView)
            make.left.equalTo(customBackgroundView).offset(10)
        }
        
        timeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(cityLabel)
            make.bottom.equalTo(cityLabel.snp.top).offset(5)
        }
        
        tempLabel.snp.makeConstraints { (make) in
            make.right.equalTo(customBackgroundView).offset(-10)
            make.top.equalTo(20)
            make.bottom.equalTo(-20)
        }
        
        weatherIcon.snp.makeConstraints { (make) in
            make.top.equalTo(customBackgroundView)//.offset(5)
            make.bottom.equalTo(customBackgroundView)//.offset(-5)
            make.right.equalTo(tempLabel.snp.left).offset(-10)
        }
        
        
    }
    

   
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        isUserInteractionEnabled = false
        addSubview(customBackgroundView)
        addSubview(cityLabel)
        addSubview(tempLabel)
        addSubview(timeLabel)
        addSubview(weatherIcon)
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
}
