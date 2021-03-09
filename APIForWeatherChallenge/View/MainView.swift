//
//  MainView.swift
//  APIForWeatherChallenge
//
//  Created by 董恩志 on 2021/3/2.
//

import UIKit

class MainView: UIView {

    let weatherTableView = UITableView()
    let fullScreenSize = UIScreen.main.bounds
    
    func setweatherTableView() {
        weatherTableView.register(WeatherTVCell.self, forCellReuseIdentifier: "Cell")
        weatherTableView.rowHeight = UITableView.automaticDimension
//        weatherTableView.rowHeight = fullScreenSize.height * 0.07
//        weatherTableView.estimatedRowHeight = 300
        weatherTableView.allowsSelectionDuringEditing = false
        weatherTableView.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
    }
    func setweatherTableViewConstraints() {
//        weatherTableView.translatesAutoresizingMaskIntoConstraints = false
//        weatherTableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
//        weatherTableView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
//        weatherTableView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
//        weatherTableView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        weatherTableView.snp.remakeConstraints { (make) in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview (weatherTableView)
        setweatherTableViewConstraints()
        setweatherTableView()
//        weatherTableView.rowHeight = UITableView.automaticDimension

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
