//
//  AppDelegate.swift
//  WeatherApplication
//
//  Created by Bishwajit Dutta on 11/07/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        if JailBreakCheck.checkForJailBreakDevice() {
            exit(-1)
        }
        return true
    }
}
