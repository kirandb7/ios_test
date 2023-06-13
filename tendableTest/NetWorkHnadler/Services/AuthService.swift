//
//  AuthService.swift
//  FoodOps
//
//  Created by Kiran Babu Davis on 07/06/23.
//

import Foundation
import Combine

protocol AuthServiceable {
    func login(request: LoginRequest) -> AnyPublisher<EmptyResponse, NetworkError>
}
class AuthService: AuthServiceable {
    
    private var networkRequest: Requestable
    private var environment: Environments = .development
    
    // inject this for testability
    init(networkRequest: Requestable, environment: Environments) {
        self.networkRequest = networkRequest
        self.environment = environment
    }
    func login(request: LoginRequest) -> AnyPublisher<EmptyResponse, NetworkError> {
        let endpoint = ServiceEndpoints.login(request: request)
        let request = endpoint.createRequest(token: "",
                                             environment: self.environment)
        return self.networkRequest.request(request)
    }
}
public struct LoginRequest: Encodable {
    public let email: String
    public let password: String
}
public struct EmptyResponse: Codable {}

