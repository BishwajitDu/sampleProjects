//
//  APIHandler.swift
//  WeatherApplication
//
//  Created by Bishwajit Dutta on 11/07/22.
//

import UIKit
import Foundation

enum APIMethodType {
    case GET
    case POST
    case PUT
    
    func toString() -> String {
        switch self {
        case .GET:
            return "GET"
        case .POST:
            return "POST"
        case .PUT:
            return "PUT"
        }
    }
}

fileprivate let headers = [Constants.rapidApiKey: Constants.apiKey, Constants.rapidAPiHostKey : Constants.hostUrl]
fileprivate let session = URLSession.shared
// Use of Type alias to use as an error string
typealias ErrorString = String


// API Handler class
class APIHandler: APIHandlerProtocol {
    
    // Method to construct the Request for the API calls
    private func constructRequest(methodName: String, parameters : [URLQueryItem], methodType: APIMethodType) -> NSMutableURLRequest? {
        guard var urlComps = URLComponents(string: "https://\(Constants.hostUrl)/\(methodName)") else { return nil }
        urlComps.queryItems = parameters
        let request = NSMutableURLRequest(url: urlComps.url ?? NSURL(string:"")! as URL ,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = methodType.toString()
        request.allHTTPHeaderFields = headers
        return request
    }
    
    func makeAPICall(methodname name:String, withParameters parms:[URLQueryItem], methodType: APIMethodType, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        if let request = constructRequest(methodName: name, parameters: parms, methodType: methodType) {
            let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
                completion(data,response,error)
            }
            task.resume()
        }
    }
}
