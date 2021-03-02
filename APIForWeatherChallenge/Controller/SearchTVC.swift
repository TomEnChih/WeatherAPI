//
//  SearchVC.swift
//  APIForWeatherChallenge
//
//  Created by 董恩志 on 2021/2/23.
//

import UIKit

class SearchTVC: UITableViewController {
    
    
    var searchController = UISearchController(searchResultsController: nil)
    //城市集合
    var cityListForAPI = [CityAPI]()
    var cityForAPI = [String]()
    //搜尋的結果集合
    var searchData:[String] = [String]()
    var isShowSearchResult: Bool = false
    var defaultCitys = ["Taipei","London","2172797","139,35","121.5319,25.0478"]
    var delegate: SearchResult!
    var cityResultForTableView: String?
    var cityResultForSearchBar: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        setTableView()
        setNavigation()
        setSearchController()
        setCitySearch()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if cityResultForTableView == nil {
            delegate.citySearch(city: cityResultForSearchBar!)
        }else{
            delegate.citySearch(city: cityResultForTableView!)
        }
    }
    
    
    
    func setCitySearch() {
        let filter = """
        {
            "name": {
                "$exists": true
            }
        }
        """.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: "https://parseapi.back4app.com/classes/Country?limit=300&keys=name&where=\(filter!)")!
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("mxsebv4KoWIGkRntXwyzg6c6DhKWQuit8Ry9sHja", forHTTPHeaderField: "X-Parse-Application-Id") // This is the fake app's application id
        urlRequest.setValue("TpO0j3lG2PmEVMXlKYQACoOXKQrL3lwM0HwR9dbH", forHTTPHeaderField: "X-Parse-Master-Key") // This is the fake app's readonly master key
        URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }else if let response = response as? HTTPURLResponse,let data = data {
                print("Status code: \(response.statusCode)")
                let decoder = JSONDecoder()
                if let cityData = try? decoder.decode(CityAPI.self, from: data) {
                    var city:[String] = []
                    
                    for i in 0..<cityData.results.count {
                        city.append(cityData.results[i].name)
                    }
                    
                    self.cityForAPI.append(contentsOf: city)
                }
                
            }
        }).resume()

    }
    
    
    
    
    func setTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        
    }
    
    func setNavigation() {
        self.title = "輸入城市"
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
    }
    
    
    func setSearchController() {
        searchController.searchBar.searchBarStyle = .prominent
        searchController.hidesNavigationBarDuringPresentation = false
        //系統不推薦
//        searchController.dimsBackgroundDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        //searchBar cancel按鈕變中文
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).title = "取消"
    }
    
    
    
}
//MARK: - set tableView
extension SearchTVC {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isShowSearchResult {
            return searchData.count
        }else{
            return defaultCitys.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell")
        cell?.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        
        if isShowSearchResult {
            cell?.textLabel?.text = searchData[indexPath.row]
        } else {
            cell?.textLabel?.text = defaultCitys[indexPath.row]
        }
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isShowSearchResult {
            cityResultForTableView = searchData[indexPath.row]
        } else {
            cityResultForTableView = defaultCitys[indexPath.row]
        }
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
}
//MARK: - search bar delegate
extension SearchTVC: UISearchBarDelegate,UISearchResultsUpdating {
    
    // 當「準備要在searchBar輸入文字時」、「取消時」都會觸發該delegate
    func updateSearchResults(for searchController: UISearchController) {
        
        if searchController.searchBar.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count == 0 {
            return
        }
        searchCityData()
        
//        guard let searchString = searchController.searchBar.text else {return}
        
        
//        if searchString.isEmpty == false {
//            searchData = city.filter { (name) -> Bool in
//                return name
//            }
//        }
    }
    
    func searchCityData() {
        searchData = cityForAPI.filter({(name) -> Bool in
            return name.lowercased().range(of: (searchController.searchBar.text!.lowercased())) != nil
        })
        if searchData.count > 0 {
            isShowSearchResult = true
            tableView.separatorStyle = UITableViewCell.SeparatorStyle.init(rawValue: 1)!
        }else{
            tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        }
        
        tableView.reloadData()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        cityResultForSearchBar = searchBar.text
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
