//
//  Requestable.swift
//  FoodOps
//
//  Created by Kiran Babu Davis on 07/06/23.
//

import Combine
import Foundation

public protocol Requestable {
    var requestTimeOut: Float { get }
    func request<T: Codable>(_ req: NetworkRequest) -> AnyPublisher<T, NetworkError>
}
