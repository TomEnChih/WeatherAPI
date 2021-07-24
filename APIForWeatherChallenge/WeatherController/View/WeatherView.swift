//
//  WeatherView.swift
//  APIForWeatherChallenge
//
//  Created by 董恩志 on 2021/7/22.
//

import UIKit

class WeatherView: UIView {
    
    // MARK: - Properties
    
    // MARK: - IBElements
    
    private let customBackgroundView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8.0
        view.layer.borderColor = UIColor.secondaryLabel.cgColor
        return view
    }()
    
    var weatherIcon: UIImageView = {
        let image = UIImageView()
        return image
    }()

    
    var tempLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.textColor = .black
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    var tempMaxLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    var tempMinLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    var tempHumanFeelLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    var sunsetLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    var sunriseLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    var windSpeedLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    lazy var leftStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [tempHumanFeelLabel,tempMaxLabel,tempMinLabel])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 0
        return stackView
    }()
    
    lazy var rightStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [sunriseLabel,sunsetLabel,windSpeedLabel])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        return stackView
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [leftStackView,rightStackView])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        return stackView
    }()
    
    lazy var currentWeatherStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [weatherIcon,tempLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        return stackView
    }()
    
    // MARK: - Autolayout
    
    private func autoLayout() {
        
        customBackgroundView.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.topMargin)
            make.centerX.equalTo(self)
            make.width.equalTo(self).multipliedBy(0.9)
            make.height.equalTo(self).multipliedBy(0.3)
        }
        
        currentWeatherStackView.snp.makeConstraints { (make) in
            make.center.equalTo(customBackgroundView)
//            make.size.equalTo(customBackgroundView).offset(0.5)
        }
        
        stackView.snp.makeConstraints { (make) in
            make.top.equalTo(customBackgroundView.snp.bottom)
            make.centerX.equalTo(self)
            make.width.equalTo(self).multipliedBy(0.8)
            make.height.equalTo(self).multipliedBy(0.4)
        }
        
        
        
    }
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .secondarySystemBackground
        addSubview(customBackgroundView)
        addSubview(currentWeatherStackView)
        addSubview(stackView)
        autoLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
}
