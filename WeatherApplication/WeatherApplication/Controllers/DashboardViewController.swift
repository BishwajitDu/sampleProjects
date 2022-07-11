//
//  ViewController.swift
//  WeatherApplication
//
//  Created by Bishwajit Dutta on 11/07/22.
//

import UIKit

class DashboardViewController: WeatherBaseViewController {
    
    @IBOutlet weak var placeLabel : UILabel?
    @IBOutlet weak var dateLabel : UILabel?
    @IBOutlet weak var weatherType : UILabel?
    @IBOutlet weak var temperature : UILabel?
    @IBOutlet weak var tempUnit : UILabel?
    @IBOutlet weak var additionalDataTable : UITableView?
    
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
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DashboardViewController") as? DashboardViewController
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
        self.additionalDataTable?.register(AdditionalDetailsCell.self, forCellReuseIdentifier: "AdditionalDetailsCell")
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
        self.placeLabel?.text = weatherData?.locationName ?? ""
        self.dateLabel?.text = weatherData?.dateTime?.changeEpochToLongDate()
        self.weatherType?.text = weatherData?.weatherType?.first?.type ?? ""
        self.temperature?.text = String(weatherData?.additionalWeatherData?.temp ?? 0.0)
        self.tempUnit?.text = "°F"
    }
}

extension DashboardViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.additionalWeatherData?.list?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AdditionalDetailsCell", for: indexPath) as? AdditionalDetailsCell else {
            return UITableViewCell()
        }
        if let dataList = self.additionalWeatherData?.list, dataList.count > 0 {
            let dataToShow = dataList[indexPath.row]
            cell.bindData(time: dataToShow.dateTime?.changeEpochToTime() ?? "00:00", humidity: "\(String(dataToShow.additionalWeatherData?.humidity ?? 0)) %", temp: "\(String(dataToShow.additionalWeatherData?.temp ?? 0.0)) °K", icon: "")
        }
        return cell
    }
    
    
}
