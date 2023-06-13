//
//  SurveyService.swift
//  tendableTest
//
//  Created by Kiran Babu Davis on 09/06/23.
//

import Foundation
import Combine

protocol SurveyServiceable {
    func getInspections() -> AnyPublisher<Inspections, NetworkError>
}
class SurveyService: SurveyServiceable {
    
    private var networkRequest: Requestable
    private var environment: Environments = .development
    
    // inject this for testability
    init(networkRequest: Requestable, environment: Environments) {
        self.networkRequest = networkRequest
        self.environment = environment
    }
    
    func getInspections() -> AnyPublisher<Inspections, NetworkError> {
        let endpoint = ServiceEndpoints.getInspections
        let request = endpoint.createRequest(token: "",
                                             environment: self.environment)
        return self.networkRequest.request(request)
    }
}

struct Inspections : Codable {
    // Define properties and methods here
}
