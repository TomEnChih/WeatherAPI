//
//  SearchView.swift
//  APIForWeatherChallenge
//
//  Created by 董恩志 on 2021/7/22.
//

import UIKit

class SearchView: UIView {

    // MARK: - Properties
    
    // MARK: - IBElements
    
    let searchtextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter city name, city ID, coordinate"
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .whileEditing
        textField.keyboardType = .default
        textField.layer.cornerRadius = 8.0
        textField.backgroundColor = .white
        textField.leftViewMode = UITextField.ViewMode.always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        return textField
    }()
    
    let cityTableView: UITableView = {
        let tv = UITableView()
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tv.backgroundColor = .secondarySystemBackground
        return tv
    }()
    
    // MARK: - Autolayout
    
    private func autoLayout() {
        
        searchtextField.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.topMargin).offset(15)
            make.centerX.equalTo(self)
            make.width.equalTo(self).offset(-50)
            make.height.equalTo(50)
        }
        
        cityTableView.snp.makeConstraints { (make) in
            make.top.equalTo(searchtextField.snp.bottom).offset(15)
            make.left.right.bottom.equalTo(self)
        }
        
        
        
    }
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .secondarySystemBackground
        addSubview(searchtextField)
        addSubview(cityTableView)
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods

}
