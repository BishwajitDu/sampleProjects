//
//  CityNameDisplayCell.swift
//  WeatherApplication
//
//  Created by Bishwajit Dutta on 11/07/22.
//

import UIKit
import SnapKit

class CityNameDisplayCell: UITableViewCell {
    
    // Created the labels programatically
    private let cityNameLbl : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.textColor = UIColor.appTextColour
        label.numberOfLines = 0
        return label
    }()
    
    private let countryNameLbl : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.textColor = UIColor.appTextColour
        label.numberOfLines = 0
        return label
    }()
    
    // Created stackView to automatically adjust the views
    private var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // Binding data to cell
    func bindData(name : String) {
        let nameArray = name.split(separator: ",").map { String($0) }
        self.cityNameLbl.text = nameArray.first ?? ""
        self.countryNameLbl.text = nameArray.last ?? ""
        self.setupCellView()
    }
    
    // Setting up the constraints manually. Used 3rd party library to do tha from Cocoa pods
    private func setupCellView() {
        self.mainStackView.addArrangedSubview(self.cityNameLbl)
        self.mainStackView.addArrangedSubview(self.countryNameLbl)
        self.addSubview(self.mainStackView)
        self.mainStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(Constants.edgeOffSet)
            make.trailing.equalToSuperview().offset(-Constants.edgeOffSet)
            make.top.equalToSuperview().offset(Constants.interElementOffSet)
            make.bottom.equalToSuperview().offset(-Constants.interElementOffSet)
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
