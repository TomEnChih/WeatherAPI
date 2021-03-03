//
//  MainView.swift
//  APIForWeatherChallenge
//
//  Created by 董恩志 on 2021/3/2.
//

import UIKit

class MainView: UIView {

    let weatherTableView = UITableView()
    
    func setweatherTableView() {
        weatherTableView.register(WeatherTVCell.self, forCellReuseIdentifier: "Cell")
//        weatherTableView.rowHeight = MainView.height * 0.08
        weatherTableView.allowsSelectionDuringEditing = false
        weatherTableView.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
//        weatherTableView.delegate = self
//        weatherTableView.dataSource = self
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(weatherTableView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
