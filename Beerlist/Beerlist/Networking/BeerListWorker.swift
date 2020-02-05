//
//  BeerListWorker.swift
//  Beerlist
//
//  Created by Andrew on 24.01.2020.
//  Copyright © 2020 Andrew. All rights reserved.
//

import Foundation

final class BeerListWorker {
    
    func fetchBeerList(page: Int, completion: @escaping (Result<[BeerItem], APIError>) -> Void) {
        DispatchQueue.global(qos: .background).async {
            let request = BeerListRequest(page: page)
            NetworkManager.shared.executeRequest(request) { (result) in
                completion(result)
            }
        }
    }
}
