//
//  NativeRequestable.swift
//  FoodOps
//
//  Created by Kiran Babu Davis on 07/06/23.
//

import Foundation
import Combine
import Foundation

public class NativeRequestable: Requestable {
    public var requestTimeOut: Float = 30

    public func request<T>(_ req: NetworkRequest) -> AnyPublisher<T, NetworkError>
     where T: Decodable, T: Encodable {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = TimeInterval(req.requestTimeOut ?? requestTimeOut)
         let decoder = JSONDecoder()
         decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        guard let url = URL(string: req.url) else {
            // Return a fail publisher if the url is invalid
            return AnyPublisher(
                Fail<T, NetworkError>(error: NetworkError.badURL(APIConstant.ErrorMessage().INVALID_URL))
            )
        }
        // We use the dataTaskPublisher from the URLSession which gives us a publisher to play around with.
         print(req.buildURLRequest(with: url))
         return URLSession.shared
            .dataTaskPublisher( for: req.buildURLRequest(with: url))
            .tryMap { output in
                     // throw an error if response is nil
                guard output.response is HTTPURLResponse else {
                    throw NetworkError.serverError(code: 0, error: APIConstant.ErrorMessage().SERVER_ERROR)
                }
                return output.data
            }
            .decode(type: T.self, decoder: decoder)
            .mapError { error in
                       // return error if json decoding fails
                NetworkError.invalidJSON(String(describing: error))
            }
            .eraseToAnyPublisher()
    }
}
