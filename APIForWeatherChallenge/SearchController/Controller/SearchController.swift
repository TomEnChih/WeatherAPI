//
//  SearchVC.swift
//  APIForWeatherChallenge
//
//  Created by 董恩志 on 2021/2/23.
//

import UIKit

class SearchController: UIViewController {
    
    // MARK: - Properties
//    var searchController = UISearchController(searchResultsController: nil)
    //搜尋的結果集合
//    var searchData:[String] = [String]()
    
    private let searchView = SearchView()
    
    //預設城市
    private let defaultCitys = ["Taipei","2172797","121.5319,25.0478"]
    //搜尋紀錄
    var cityRecord = [String]()
    
    var delegate: SearchResult!
    private var isShowSearchResult: Bool = false
    
    
    var container: CityContainer = .init() {
        didSet {
            self.searchView.cityTableView.reloadData()
        }
    }
    
    
    enum CellType {
        case defaultCity
        case record
    }
    
    private var defaultsection: [CellType] = [.defaultCity,.record]
    
    var searchData = [City]()
    var searchResult: [City] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view = searchView
        searchView.cityTableView.delegate = self
        searchView.cityTableView.dataSource = self
        searchView.searchtextField.delegate = self
        setNavigationItem()
        searchView.searchtextField.addTarget(self, action: #selector(handleSearchCity), for: .editingChanged)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        searchView.cityTableView.reloadData()
    }

    
    // MARK: - Methods
    
    func setNavigationItem() {
        navigationItem.title = "Add City"
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "return"), style: .plain, target: self, action: #selector(handleCancel))
    }
    
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleSearchCity() {
        
        if searchView.searchtextField.text?.isEmpty == true {
            isShowSearchResult = false
            
        } else {
            isShowSearchResult = true
            searchResult = searchData.filter { (city) -> Bool in
                city.countryName.lowercased().contains((searchView.searchtextField.text?.lowercased())!)
            }
        }
        self.searchView.cityTableView.reloadData()
    }
    
}

//MARK: - UITableViewDelegate,UITableViewDataSource

extension SearchController: UITableViewDelegate,UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        defaultsection.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch defaultsection[section] {
        case .defaultCity:
            return defaultCitys.count
        case .record:
            if isShowSearchResult == false {
                return cityRecord.count
            }
            return searchResult.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch defaultsection[indexPath.section] {
            
        case .defaultCity:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
            
            cell?.textLabel?.text = defaultCitys[indexPath.row]

            return cell!
            
        case .record:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
            
            if isShowSearchResult == false {
                cell?.textLabel?.text = cityRecord[indexPath.row]
                
            } else {
                cell?.textLabel?.text = searchResult[indexPath.row].countryName

            }
            
            return cell!
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch defaultsection[indexPath.section] {

        case .defaultCity:

            let city = defaultCitys[indexPath.row]
            cityRecord.insert(city, at: 0)
            delegate.citySearch(city: city, searchRecord: cityRecord)
            dismiss(animated: true, completion: nil)
            
        case .record:

            guard isShowSearchResult == true else {
                
                let city = cityRecord[indexPath.row]
                cityRecord.insert(city, at: 0)
                delegate.citySearch(city: city, searchRecord: cityRecord)
                dismiss(animated: true, completion: nil)
                return
            }
            
            let city = searchResult[indexPath.row].countryName
            cityRecord.insert(city, at: 0)
            delegate.citySearch(city: city, searchRecord: cityRecord)
            dismiss(animated: true, completion: nil)
        }
    }
    
    // Header
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch defaultsection[section] {
            
        case .defaultCity:

            let title = "Default"

            return title
            
        case .record:
                       
            guard isShowSearchResult == false else {
                let title = "Search"
                
                return title
            }
            
            let title = "Record"

            return title
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        50
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let tableView = view as? UITableViewHeaderFooterView else { return }
        tableView.contentView.backgroundColor = .secondarySystemBackground
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        UIView()
    }
}

extension SearchController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        guard let text = textField.text,text != "" else { return true }
        cityRecord.insert(text, at: 0)
        delegate.citySearch(city: text, searchRecord: cityRecord)
        dismiss(animated: true, completion: nil)
        return true
    }
}

//MARK: -mentor 的搜尋方式 (struct 計算屬性)
//可以讓code更乾淨，不會有這麼多city的儲存屬性擠在一起
struct CityContainer {
    //儲存屬性 存城市資料
    private var cities: [String] = []
    //判斷顯示的城市資料
    var keyword: String = ""
    var filterdCities: [String] {
        if keyword != "" {
            return cities.filter({$0.contains(keyword)})
        } else {
            return cities
        }
    }
    
    //接 API 的城市資料
    mutating func updateCities(cities: [String]) {
        self.cities = cities
    }
}
