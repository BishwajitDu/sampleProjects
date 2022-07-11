//
//  ResponseHandler.swift
//  WeatherApplication
//
//  Created by Bishwajit Dutta on 11/07/22.
//

import UIKit
import Foundation

// Use of generics for success and failure
enum ResponseHandler<S, F:WeatherAppError> {
    case Success(S)
    case Failure(F)
}

// Custom class for local error
class WeatherAppError : Error {
    var localizedDescription = "Data returned from server is nil."
}
