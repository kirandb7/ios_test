//
//  ServiceEndpoints.swift
//  FoodOps
//
//  Created by Kiran Babu Davis on 07/06/23.
//

import Foundation
public typealias Headers = [String: String]

enum ServiceEndpoints {
    
  // organise all the end points here for clarity
    case login(request: LoginRequest)
    case getInspections
    
  // gave a default timeout but can be different for each.
    var requestTimeOut: Int {
        return 20
    }
    
  //specify the type of HTTP request
    var httpMethod: HTTPMethod {
        switch self {
        case .login:
            return .POST
        case .getInspections:
            return .GET
        }
    }
    
  // compose the NetworkRequest
    func createRequest(token: String, environment: Environments) -> NetworkRequest {
        var headers: Headers = [:]
        headers["Content-Type"] = "application/json"
        headers["Authorization"] = "Bearer \(token)"
        return NetworkRequest(url: getURL(from: environment), headers: headers, reqBody: requestBody, httpMethod: httpMethod)
    }
    
  // encodable request body for POST
    var requestBody: Encodable? {
        switch self {
        case .login(let request):
            return request
        default:
            return nil
        }
    }
    // compose urls for each request
    func getURL(from environment: Environments) -> String {
        let baseUrl = environment.baseUrl
        switch self {
        case .login:
            return "\(baseUrl)/api/login/"
        case .getInspections:
            return "\(baseUrl)/api/inspections/start"
        }
    }
}
