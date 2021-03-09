//
//  SearchVC.swift
//  APIForWeatherChallenge
//
//  Created by 董恩志 on 2021/2/23.
//

import UIKit
import Lottie

class SearchTVC: UITableViewController {
    
    var searchController = UISearchController(searchResultsController: nil)
    //搜尋的結果集合
//    var searchData:[String] = [String]()
    //預設城市
    var defaultCitys = ["Taipei","London","2172797","139,35","121.5319,25.0478"]
    var delegate: SearchResult!
    var cityResultForTableView: String?
    var cityResultForSearchBar: String?
    var isShowSearchResult: Bool = false
    let searchTableViewCellID = "MyCell"
    var container: CityContainer = .init() {
        didSet {
            tableView.reloadData()
        }
    }
    
    
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
            delegate.citySearch(city: cityResultForSearchBar ?? "")
        }else{
            delegate.citySearch(city: cityResultForTableView ?? "")
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
                    
                    self.container.updateCities(cities: cityData.results)
                }
                
            }
        }).resume()

    }
    
    
    
    //MARK: tableView
    func setTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: searchTableViewCellID)
        
    }
    //MARK: navigation
    func setNavigation() {
        self.title = "輸入城市、座標、編號"
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
    }
    //MARK: searchController
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
//extension SearchTVC {
//
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if isShowSearchResult {
//            return searchData.count
//        }else{
//            return defaultCitys.count
//        }
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell")
//        cell?.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
//
//        if isShowSearchResult {
//            cell?.textLabel?.text = searchData[indexPath.row]
//        } else {
//            cell?.textLabel?.text = defaultCitys[indexPath.row]
//        }
//
//        return cell!
//    }
//
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if isShowSearchResult {
//            cityResultForTableView = searchData[indexPath.row]
//        } else {
//            cityResultForTableView = defaultCitys[indexPath.row]
//        }
//        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
//    }
//
//}
extension SearchTVC {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isShowSearchResult {
            return container.filterdCities.count
        }else{
            return defaultCitys.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: searchTableViewCellID)
        cell?.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)

        if isShowSearchResult {
            cell?.textLabel?.text = container.filterdCities[indexPath.row].name
        } else {
            cell?.textLabel?.text = defaultCitys[indexPath.row]
        }

        return cell!
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isShowSearchResult {
            cityResultForTableView = container.filterdCities[indexPath.row].name
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
        //還不是很懂
        //若是沒有輸入任何文字或輸入空白則直接返回不做搜尋的動作
        if searchController.searchBar.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count == 0 {
            isShowSearchResult = false
        }else{
            isShowSearchResult = true
            container.keyword = searchController.searchBar.text ?? ""
//            searchCityData()
        }
        tableView.reloadData()
    }
    
//    #warning("struct 計算屬性")
//    func searchCityData() {
//        //name 是指 array 裡頭的資料
//        //若 array 裡頭有資料符合 searchbar.text 會被加進 searchData
//        //lowercased 讓資料都變小寫，就不會有大小寫差異
//        searchData = cityForAPI.filter({(name) -> Bool in
//            return name.lowercased().range(of: (searchController.searchBar.text!.lowercased())) != nil
//        })
//    }
    
    //結束編輯時的func
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        cityResultForSearchBar = searchBar.text
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}

//MARK: -mentor 的搜尋方式 (struct 計算屬性)
//可以讓code更乾淨，不會有這麼多city的儲存屬性擠在一起
struct CityContainer {
    //儲存屬性 存城市資料
    private var cities: [Result] = []
    //判斷顯示的城市資料
    var keyword: String = ""
    var filterdCities: [Result] {
        if keyword != "" {
            return cities.filter({$0.name.contains(keyword)})
        } else {
            return cities
        }
    }
    
    //接 API 的城市資料
    mutating func updateCities(cities: [Result]) {
        self.cities = cities
        print(cities)
    }
}
