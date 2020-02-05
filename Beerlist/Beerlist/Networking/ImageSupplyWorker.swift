//
//  ImageSupplyWorker.swift
//  Beerlist
//
//  Created by Andrew on 04.02.2020.
//  Copyright © 2020 Andrew. All rights reserved.
//

import UIKit

protocol ImageSupply {
    
    func getImage(url: String, completion: @escaping (Result<UIImage, APIError>) -> ())
}

final class ImageSupplyWorker: ImageSupply {
    
    private lazy var imageCache = NSCache<NSString, UIImage>()

    func getImage(url: String, completion: @escaping (Result<UIImage, APIError>) -> ()) {
        
        if let image = imageCache.object(forKey: NSString(string: url)) {
            completion(.success(image))
        } else {
            NetworkManager.shared.fetchImage(url: url) { [weak self] result in
                if case .success(let image) = result {
                    self?.imageCache.setObject(image, forKey: NSString(string: url))
                }
                completion(result)
            }
        }
    }
}
