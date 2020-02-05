//
//  PunkAPIEndpoint.swift
//  MovieList
//
//  Created by Andrew on 30.01.2020.
//  Copyright © 2020 Andrew. All rights reserved.
//

import Foundation

enum PunkAPIEndpoint: NetworkEndpoint {

    var baseUrl: String {
        NetworkManager.shared.configuration.baseURL
    }
    
    case beerList
    
    var path: String {
        switch self {
        case .beerList:
            return "beers"
        }
    }
}
