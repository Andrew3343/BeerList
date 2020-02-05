//
//  BeerListRequest.swift
//  Beerlist
//
//  Created by Andrew on 24.01.2020.
//  Copyright © 2020 Andrew. All rights reserved.
//

import Foundation

final class BeerListRequest: NetworkRequest {
    typealias ResultType = [BeerItem]
    
    var endPoint: NetworkEndpoint {
        PunkAPIEndpoint.beerList
    }
    
    private let page: Int
    
    var httpMethod: HTTPMethod {
        .GET
    }
    
    var bodyParams: [String : String]? {
        nil
    }
    
    var queryParams: [String : String]? {
        ["page" : String(page)]
    }
    
    init(page: Int) {
        self.page = page
    }
}
