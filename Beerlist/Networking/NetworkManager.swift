//
//  NetworkRequestor.swift
//  MovieList
//
//  Created by Andrew on 23.01.2020.
//  Copyright © 2020 Andrew. All rights reserved.
//

import UIKit

protocol APIConfiguration {
    var baseURL: String { get }
}

struct PunkAPIConfiguration : APIConfiguration {
    
    var baseURL: String {
        "https://api.punkapi.com/v2/"
    }
}

final class NetworkManager {
    
    static let shared: NetworkManager = NetworkManager(configuration: PunkAPIConfiguration())
    
    var configuration: APIConfiguration
    
    private var imageLoadingService = ImageLoadingService()
    
    private var urlSession: URLSession = URLSession.shared
    // use shared session for demo purposes
    
    private init(configuration: APIConfiguration) {
        self.configuration = configuration
    }
    
    deinit {
        urlSession.invalidateAndCancel()
    }
    
    func fetchImage(url: String, completion: @escaping (Result<UIImage, APIError>) -> ()) {
        imageLoadingService.fetchImage(url: url, completion: completion)
    }

    @discardableResult
    func executeRequest<T: NetworkRequest>(_ request: T, completion:  @escaping (Result<T.ResultType, APIError>) -> Void) -> URLSessionDataTask? {
        
        guard let urlRequest = request.buildRequest() else {
            return nil
        }
        
        let task = decodingTask(with: urlRequest, decodingType: T.ResultType.self, completionHandler: completion)
        task.resume()
        return task
    }
    
    private func decodingTask<T: Decodable>(with request: URLRequest, decodingType: T.Type, completionHandler completion: @escaping (Result<T, APIError>) -> Void) -> URLSessionDataTask {
       
        let task = urlSession.dataTask(with: request) { data, response, error in
            
            if let error = error {
                if (error as NSError).code == NSURLErrorCancelled {
                    completion(.failure(.requestCancelled))
                } else {
                    completion(.failure(.requestFailed))
                }
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.requestFailed))
                return
            }
            
            if httpResponse.statusCode == HTTPStatusCode.ok.rawValue {
                
                if let data = data {
                    do {
                        let genericModel = try JSONDecoder().decode(decodingType, from: data)
                        completion(.success(genericModel))
                    } catch {
                        completion(.failure(.jsonParsingFailure))
                    }
                    
                } else {
                    completion(.failure(.invalidData))
                }
            } else {
                completion(.failure(.responseUnsuccessful))
            }
        }
        return task
    }
}
