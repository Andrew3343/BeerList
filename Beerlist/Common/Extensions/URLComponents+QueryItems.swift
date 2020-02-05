//
//  URLComponents+QueryItems.swift
//  Beerlist
//
//  Created by Andrew on 04.02.2020.
//  Copyright © 2020 Andrew. All rights reserved.
//

import Foundation

extension URLComponents {
    
    mutating func setQueryItems(with parameters: [String: String]) {
        self.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
    }
}
