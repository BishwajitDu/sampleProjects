//
//  AppBaseViewController.swift
//  WeatherApplication
//
//  Created by Bishwajit Dutta on 11/07/22.
//

import UIKit
import SnapKit

// Type Alias created for protocol and controller
typealias WeatherBaseViewController = AppBaseViewController & ControllerDefaultMethods

protocol ControllerDefaultMethods {
    func setupView()
    func fetchData()
}

class AppBaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
