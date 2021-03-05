//
//  WeatherView.swift
//  APIForWeatherChallenge
//
//  Created by 董恩志 on 2021/2/22.
//

import UIKit

class FooterView: UIView {
    
    
    let footerSearchButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "search"), for: .normal)
        return button
    }()
    
    lazy var footerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [leftLabel,middleLabel,rightLabel])
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    let leftLabel: UILabel = {
        let label = UILabel()
        label.text = "°C"
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        return label
    }()
    let middleLabel: UILabel = {
        let label = UILabel()
        label.text = " / "
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        return label
    }()
    let rightLabel: UILabel = {
        let label = UILabel()
        label.text = "°F"
        label.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        return label
    }()
    
    func setFooterElementConstraints() {
        let footerSearchButton = self.footerSearchButton
        footerSearchButton.translatesAutoresizingMaskIntoConstraints = false
        footerSearchButton.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -10).isActive = true
        footerSearchButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        footerSearchButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        footerSearchButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        let footerStackView = self.footerStackView
        footerStackView.translatesAutoresizingMaskIntoConstraints = false
        footerStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 10).isActive = true
        footerStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
   
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        addSubview(footerSearchButton)
        addSubview(footerStackView)
        setFooterElementConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
