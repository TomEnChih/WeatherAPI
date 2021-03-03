//
//  ViewController.swift
//  APIForWeatherChallenge
//
//  Created by 董恩志 on 2021/2/18.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate {
    
    var weathers = [WeatherData]()
    var tempMode: tempTransform = .C
    var weatherTableView = UITableView() 
    let fullScreenSize = UIScreen.main.bounds
    
    let footerView = FooterView()
    
    func setCurrentWeather(city:String) {
        let address = "http://api.openweathermap.org/data/2.5/weather?"
        let urlDetermine:URL
        let modeSelect = Int(city)
        
        if city.contains(","){
            
            let cityCoord = city.components(separatedBy: ",")
            urlDetermine = URL(string: address+"lat=\(cityCoord[1])"+"&lon=\(cityCoord[0])"+"&units=metric"+"&appid=\(AppID.id)")!
        }else{
            
            if modeSelect != nil {
                
                urlDetermine = URL(string:address+"id=\(city)"+"&units=metric"+"&appid=\(AppID.id)")!
                
            }else{
                urlDetermine = URL(string:address+"q=\(city.urlEncoded())"+"&units=metric"+"&appid=\(AppID.id)")!
                
            }
        }
        
        
        let url = urlDetermine
        if  url == url {
            URLSession.shared.dataTask(with: url){(data,response,error) in
                DispatchQueue.main.async {
                    if let error = error {
                        print("Error: \(error.localizedDescription)")
                    } else if let response = response as? HTTPURLResponse,let data = data {
                        print("Status code: \(response.statusCode)")
                        let decoder = JSONDecoder()
                        
                        if let weatherData = try? decoder.decode(WeatherData.self, from: data) {
                            
//                            print(weatherData)
//                            print("城市名稱: \(weatherData.name)")
//                            print("經緯度: (\(weatherData.coord.lon),\(weatherData.coord.lat))")
//                            print("溫度: \(weatherData.main.temp)°C")
//                            print("描述: \(weatherData.weather[0].description)")
                            self.weathers.append(weatherData)
                            self.weatherTableView.reloadData()
                            
                        }
                    }
                }
            }.resume()
        }else {
            print("Invalid URL")
        }
        
    }
    
    
    
    func setweatherTableView() {
        weatherTableView.register(WeatherTVCell.self, forCellReuseIdentifier: "Cell")
        weatherTableView.rowHeight = fullScreenSize.height * 0.08
        weatherTableView.allowsSelectionDuringEditing = false
        weatherTableView.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        weatherTableView.delegate = self
        weatherTableView.dataSource = self
        view.addSubview(weatherTableView)
    }
    
    //MARK: - autoLayout
    func setweatherTableViewConstraints() {
        weatherTableView.translatesAutoresizingMaskIntoConstraints = false
        weatherTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        weatherTableView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        weatherTableView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        weatherTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func setFooterElementConstraints() {
        let footerSearchButton = footerView.footerSearchButton
        footerSearchButton.translatesAutoresizingMaskIntoConstraints = false
        footerSearchButton.trailingAnchor.constraint(equalTo: footerView.trailingAnchor,constant: -10).isActive = true
        footerSearchButton.centerYAnchor.constraint(equalTo: footerView.centerYAnchor).isActive = true
        footerSearchButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        footerSearchButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        let footerStackView = footerView.footerStackView
        footerStackView.translatesAutoresizingMaskIntoConstraints = false
        footerStackView.leadingAnchor.constraint(equalTo: footerView.leadingAnchor,constant: 10).isActive = true
        footerStackView.centerYAnchor.constraint(equalTo: footerView.centerYAnchor).isActive = true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        setweatherTableView()
        setweatherTableViewConstraints()
        setCurrentWeather(city: "taipei")
        setFooterElementConstraints()
        singleFinger()
        footerView.footerSearchButton.addTarget(self, action: #selector(searchCityButton(sender:)), for: .touchUpInside)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        presentLoadingVC()
    }

    
    //MARK: - 刪除
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        weathers.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "刪除"
    }
    
    //MARK: - footer
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return fullScreenSize.height * 0.07
    }
    
    @objc func searchCityButton(sender: UIButton) {
        let vc = SearchTVC()
        let nav = UINavigationController(rootViewController: vc)
        vc.delegate = self
        nav.modalPresentationStyle = .overCurrentContext
        present(nav, animated: true, completion: nil)
    }
    
    @objc func loading(sender: UIButton) {
        presentLoadingVC()
    }
    
    
    
    //MARK: - 手勢
    func singleFinger() {
        let singleFinger = UITapGestureRecognizer(target: self, action: #selector(fingleTap))
        singleFinger.numberOfTapsRequired = 1
        singleFinger.numberOfTouchesRequired = 1
        //為元件加入手勢的func
        footerView.footerStackView.addGestureRecognizer(singleFinger)
    }
    
    @objc func fingleTap() {
        let leftLabel = footerView.leftLabel
        let righthLabel = footerView.rightLabel
        if leftLabel.textColor == #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1) {
            leftLabel.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            righthLabel.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            tempMode = .F
        }else if leftLabel.textColor == #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1) {
            leftLabel.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            righthLabel.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            tempMode = .C
        }
        weatherTableView.reloadData()
        
    }
}
//MARK: - tableViewData
extension ViewController: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weathers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = weatherTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! WeatherTVCell
        let weatherIndex = weathers[indexPath.row]
        cell.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        cell.isUserInteractionEnabled = false
        
        let url = URL(string: "http://openweathermap.org/img/wn/\(weatherIndex.weather[0].icon)@2x.png")
        let data = try? Data(contentsOf: url!)
        if let imageData = data {
            let image = UIImage(data: imageData)
            cell.weatherIcon.image = image!
        }
        
        cell.cityLabel.text = weatherIndex.name
        cell.timeLabel.text = weatherIndex.dt.timetransform()
        switch tempMode {
        case .C : cell.tempLabel.text = String(weatherIndex.main.temp.numberTransform)+"°"
        case .F : cell.tempLabel.text = String((weatherIndex.main.temp * 9/5 + 32).numberTransform)+"°"
        }
        return cell
    }
}

//MARK: - delegate
extension ViewController: SearchResult {
    func citySearch(city: String) {
        presentLoadingVC()
        setCurrentWeather(city: city)
    }
}
//MARK: - loading 畫面
extension ViewController {
    func presentLoadingVC() {
        let vc = LoadingViewController()
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true, completion: nil)
    }
}
