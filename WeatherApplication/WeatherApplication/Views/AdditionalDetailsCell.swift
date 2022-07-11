//
//  AdditionalDetailsCell.swift
//  WeatherApplication
//
//  Created by Bishwajit Dutta on 11/07/22.
//

import UIKit
import SnapKit

class AdditionalDetailsCell: UITableViewCell {

    // Created the labels programatically
    private let time : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.textColor = UIColor.white
        label.numberOfLines = 0
        return label
    }()
    
    private let temperature : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.textColor = UIColor.white
        label.numberOfLines = 0
        return label
    }()
    
    
    private let humidity : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.textColor = UIColor.white
        label.numberOfLines = 0
        return label
    }()
    
    private var iconView : UIImageView = UIImageView()
    
    // Created stackView to automatically adjust the views
    private var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    func bindData(time: String, humidity: String, temp: String, icon: String) {
        self.humidity.text = humidity
        self.time.text = time
        self.temperature.text = temp
        setupCellView()
    }
    
    // Setting up the constraints manually. Used 3rd party library to do tha from Cocoa pods
    private func setupCellView() {
        self.backgroundColor = UIColor.clear
        self.mainStackView.addArrangedSubview(self.time)
        self.mainStackView.addArrangedSubview(self.iconView)
        self.mainStackView.addArrangedSubview(self.temperature)
        self.mainStackView.addArrangedSubview(self.humidity)
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

        // Configure the view for the selected state
    }

}
