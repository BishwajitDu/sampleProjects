//
//  ViewController.swift
//  WeatherApplication
//
//  Created by Bishwajit Dutta on 11/07/22.
//

import UIKit

class DashboardViewController: WeatherBaseViewController {
    
    @IBOutlet private weak var placeLbl : UILabel?
    @IBOutlet private weak var dateLbl : UILabel?
    @IBOutlet private weak var weatherTypeLbl : UILabel?
    @IBOutlet private weak var temperatureLbl : UILabel?
    @IBOutlet private weak var temperatureUnitLbl : UILabel?
    @IBOutlet private weak var additionalDataTable : UITableView?
    
    var apiErrorMessage : String?
    
    // Observing the value change for the variables
    var weatherData : WeatherData? {
        didSet{
            showCurrentWeatherData()
        }
    }
    
    var additionalWeatherData : WeatherMasterData? {
        didSet {
            additionalDataTable?.reloadData()
        }
    }
    
    var viewModel : WeatherDashboardViewModel?
    
    // Instanciating controller from storyboard
    static func getDashboardViewController(withViewModel: WeatherDashboardViewModel) -> WeatherBaseViewController? {
        let viewController = UIStoryboard(name: Constants.mainStoryboard, bundle: nil).instantiateViewController(withIdentifier: Constants.dashboardControllerName) as? DashboardViewController
        viewController?.viewModel = withViewModel
        return viewController
    }
    
    // Self Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.fetchData()
    }
    
    func setupView() {
        placeLbl?.textColor = UIColor.white
        dateLbl?.textColor = UIColor.white
        weatherTypeLbl?.textColor = UIColor.white
        temperatureLbl?.textColor = UIColor.white
        temperatureUnitLbl?.textColor = UIColor.white
        self.additionalDataTable?.register(AdditionalDetailsCell.self, forCellReuseIdentifier: Constants.additionalDetailsCell)
        self.additionalDataTable?.backgroundColor = UIColor.clear
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    func fetchData() {
        viewModel?.fetchCurrentWeatherFromAPI()
        viewModel?.fetchMasterWeatherDataFromAPI()
        weatherDashboardSemaphore.wait()
        self.weatherData = viewModel?.weatherData
        self.additionalWeatherData = viewModel?.weatherMasterData
        self.apiErrorMessage = viewModel?.errorMessage
        weatherDashboardSemaphore.signal()
    }
    
    private func showCurrentWeatherData() {
        self.placeLbl?.text = weatherData?.locationName ?? ""
        self.dateLbl?.text = weatherData?.dateTime?.changeEpochToLongDate()
        self.weatherTypeLbl?.text = weatherData?.weatherType?.first?.type ?? ""
        self.temperatureLbl?.text = String(weatherData?.additionalWeatherData?.temp ?? 0.0)
        self.temperatureUnitLbl?.text = "°F"
    }
}

//MARK: TableView Delegate
extension DashboardViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.additionalWeatherData?.list?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.additionalDetailsCell, for: indexPath) as? AdditionalDetailsCell else {
            return UITableViewCell()
        }
        if let dataList = self.additionalWeatherData?.list, dataList.count > 0 {
            let dataToShow = dataList[indexPath.row]
            cell.bindData(time: dataToShow.dateTime?.changeEpochToTime(),
                          humidity: dataToShow.additionalWeatherData?.humidity,
                          temp: dataToShow.additionalWeatherData?.temp,
                          icon: "")
        }
        return cell
    }
}
