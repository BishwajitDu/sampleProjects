//
//  MockAPIHandler.swift
//  WeatherApplicationTests
//
//  Created by Bishwajit Dutta on 18/07/22.
//

import UIKit
@testable import WeatherApplication

class MockAPIHandler: APIHandlerProtocol {
    
    var checkSuccess : Bool = true
    
    func makeAPICall(methodname name:String, withParameters parms:[URLQueryItem], methodType: APIMethodType, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        if checkSuccess == true {
            self.APISuccess(completion: completion)
        } else {
            self.APIFailure(completion: completion)
        }
    }
    
    private func APIFailure(completion: (Data?, URLResponse?, Error?) -> Void)  {
        completion(nil,nil,WeatherAppError())
    }
    
    
    private func APISuccess(completion: (Data?, URLResponse?, Error?) -> Void) {
        completion("Test".data(using: .utf8),nil,nil)
    }
}
