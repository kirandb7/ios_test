//
//  Environment.swift
//  FoodOps
//
//  Created by Kiran Babu Davis on 07/06/23.
//

import Foundation

public enum Environments: String, CaseIterable {
    case development
    case staging
    case production
}
extension Environments {
    var baseUrl: String {
        switch self {
        case .development:
            return getLocalURL() ?? Constant.Common().empty
        case .staging:
            return ""
        case .production:
            return ""
        }
    }
    func getLocalURL() -> String?{
        var components = URLComponents()
        components.scheme = "http"
        components.host = "127.0.0.1"
        components.port = 5001
        //components.path = "/api/login"
        guard let url = components.url else { return nil }
        return url.absoluteString
    }
}
