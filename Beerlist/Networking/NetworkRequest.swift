//
//  NetworkRequest.swift
//  Beerlist
//
//  Created by Andrew on 05.02.2020.
//  Copyright © 2020 Andrew. All rights reserved.
//

import Foundation

protocol NetworkRequest {
    associatedtype ResultType: Decodable
    
    var endPoint: NetworkEndpoint { get }
    var httpMethod: HTTPMethod { get }
    var bodyParams: [String: String]? { get }
    var queryParams: [String: String]? { get }
}

extension NetworkRequest {
    
    var fullURL: URL? {
        
        let urlString = endPoint.endpointURL
        guard let queryParams = queryParams else {
            return URL(string: urlString)
        }
        var urlComponents = URLComponents(string: urlString)
        urlComponents?.setQueryItems(with: queryParams)
        return urlComponents?.url
    }
    
    func buildRequest() -> URLRequest? {
        
        guard let url = fullURL else {
            return nil
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.rawValue
        return urlRequest
    }
}
