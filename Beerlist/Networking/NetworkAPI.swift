//
//  NetworkAPI.swift
//  MovieList
//
//  Created by Andrew on 23.01.2020.
//  Copyright © 2020 Andrew. All rights reserved.
//

import UIKit

protocol NetworkEndpoint {
    
    var baseUrl: String { get }
    var path: String { get }
}

extension NetworkEndpoint {
    
    var endpointURL: String {
        return baseUrl + path
    }
}

enum HTTPMethod: String {
    
    case GET = "GET"
    case POST = "POST"
    case PATCH = "PATCH"
    case DELETE = "DELETE"
}

enum HTTPStatusCode: Int {
    
    case ok = 200
    // add others here
}

enum APIError: Error {
    
    case requestCancelled
    case requestFailed
    case invalidData
    case responseUnsuccessful
    case jsonParsingFailure
    case imageInstantiationFailure
    
    var localizedDescription: String {
        switch self {
        case .requestCancelled:
            return "Request Cancelled"
        case .imageInstantiationFailure:
            return "Failed to construct image from data"
        case .requestFailed:
            return "Request Failed"
        case .invalidData:
            return "Invalid Data"
        case .responseUnsuccessful:
            return "Response Unsuccessful"
        case .jsonParsingFailure:
            return "JSON Parsing Failure"
        }
    }
}
