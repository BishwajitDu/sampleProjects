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
    private let timeLbl : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.textColor = UIColor.white
        label.numberOfLines = 0
        return label
    }()
    
    private let temperatureLbl : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.textColor = UIColor.white
        label.numberOfLines = 0
        return label
    }()
    
    
    private let humidityLbl : UILabel = {
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
    
    // Binding data for the cell
    func bindData(time: String?, humidity: Float?, temp: Float?, icon: String?) {
        self.humidityLbl.text = "\(String(humidity ?? 0)) %"
        self.timeLbl.text = time ?? "00:00"
        self.temperatureLbl.text = "\(String(temp ?? 0.0)) °K"
        setupCellView()
    }
    
    // Setting up the constraints manually. Used 3rd party library to do tha from Cocoa pods
    private func setupCellView() {
        self.backgroundColor = UIColor.clear
        self.mainStackView.addArrangedSubview(self.timeLbl)
        self.mainStackView.addArrangedSubview(self.iconView)
        self.mainStackView.addArrangedSubview(self.temperatureLbl)
        self.mainStackView.addArrangedSubview(self.humidityLbl)
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
