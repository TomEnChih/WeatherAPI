//
//  MainView.swift
//  APIForWeatherChallenge
//
//  Created by 董恩志 on 2021/3/2.
//

import UIKit

class MainView: UIView {
    // MARK: - Properties
    
    // MARK: - IBElements
    
    let weatherTableView: UITableView = {
        let tv = UITableView()
        tv.register(WeatherTVCell.self, forCellReuseIdentifier: WeatherTVCell.id)
//        tv.allowsSelectionDuringEditing = false
        tv.backgroundColor = .clear
        tv.separatorStyle = .none
        
        return tv
    }()
    
    // MARK: - Autolayout
    private func autoLayout() {

        weatherTableView.snp.remakeConstraints { (make) in
            make.top.equalTo(self.snp.topMargin)
            make.bottom.leading.trailing.equalToSuperview()
        }
        
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .secondarySystemBackground
        addSubview (weatherTableView)
        autoLayout()
//        setGradientLayer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
