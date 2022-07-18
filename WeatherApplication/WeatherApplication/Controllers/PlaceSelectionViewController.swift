//
//  PlaceSelectionViewController.swift
//  WeatherApplication
//
//  Created by Bishwajit Dutta on 11/07/22.
//

import UIKit

class PlaceSelectionViewController: WeatherBaseViewController {
    
    // Using lazy keyword so that the table view is created only once. This will be re used so used lazy
    private lazy var cityTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = UIColor.appTextColour
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        tableView.register(CityNameDisplayCell.self, forCellReuseIdentifier: Constants.cityNameDisplayCell)
        tableView.dataSource = self
        tableView.rowHeight = 65
        return tableView
    }()
    
    // Created the lable programatically
    let titleText : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 21, weight: .semibold)
        label.textColor = UIColor.appTextColour
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    var viewModel : PlaceSelectionViewModelProtocol?
    
    var cityList : [String] = [] {
        didSet{
            self.cityTableView.reloadData()
        }
    }

    // Self methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // The variables can be used with out self. Few places that is the apple standard.
        viewModel = PlaceSelectionViewModel()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
        setupView()
    }
    
    // Protocol functions
    func setupView() {
        self.view.addSubview(titleText)
        self.view.addSubview(cityTableView)
        titleText.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(Constants.edgeOffSet)
            make.trailing.equalToSuperview().offset(-Constants.edgeOffSet)
            make.top.equalToSuperview().offset(Constants.headerTextViewOffset)
        }
        
        cityTableView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(Constants.interElementOffSet)
            make.trailing.equalToSuperview().offset(-Constants.interElementOffSet)
            make.top.equalTo(titleText.snp.bottom).offset(Constants.interElementOffSet)
            make.bottom.equalToSuperview().offset(-Constants.interElementOffSet)
        }
    }
    
    func fetchData() {
        // Need to get the data from view model
        self.titleText.text = viewModel?.screenTitle() ?? ""
        self.cityList = viewModel?.fetchCityList() ?? []
    }

}

//MARK: Table view delegate and data source
extension PlaceSelectionViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cityList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cityNameDisplayCell, for: indexPath) as? CityNameDisplayCell else {
            return UITableViewCell()
        }
        cell.bindData(name: self.cityList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let nextViewCOntroller = DashboardViewController.getDashboardViewController(withViewModel: WeatherDashboardViewModel(cityName: self.cityList[indexPath.row])) else { return }
        self.navigationController?.pushViewController(nextViewCOntroller, animated: true)
    }
    
}
