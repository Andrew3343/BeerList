//
//  ImageLoadingService.swift
//  Beerlist
//
//  Created by Andrew on 30.01.2020.
//  Copyright © 2020 Andrew. All rights reserved.
//

import UIKit

final class ImageLoadingService {
    
    private lazy var session: URLSession = URLSession.shared
    
    private lazy var imageHandlingQueue: OperationQueue = {
        let operationQueue = OperationQueue()
        operationQueue.qualityOfService = .background
        operationQueue.maxConcurrentOperationCount = 5
        return operationQueue
    }()
    
    func fetchImage(url: String, completion: @escaping (Result<UIImage, APIError>) -> ()) {
        
        guard let url = URL(string: url) else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.GET.rawValue
        
        let task = session.dataTask(with: request) { [weak self] data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.requestFailed))
                return
            }
            if httpResponse.statusCode == HTTPStatusCode.ok.rawValue {
                if let data = data {
                    self?.imageHandlingQueue.addOperation {
                        guard let image = UIImage(data: data) else {
                            completion(.failure(.imageInstantiationFailure))
                            return
                        }
                        completion(.success(image))
                    }
                    return
                        
                } else {
                    completion(.failure(.invalidData))
                }
            } else {
                completion(.failure(.responseUnsuccessful))
            }
        }
        task.resume()
    }
}
