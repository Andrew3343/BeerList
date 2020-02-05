//
//  BeerItem.swift
//  Beerlist
//
//  Created by Andrew on 04.02.2020.
//  Copyright © 2020 Andrew. All rights reserved.
//

import Foundation

final class BeerItem: Decodable {
    
    private enum Keys: String, CodingKey {
        case name
        case tagline
        case description
        case imageURL = "image_url"
    }
    
    var name: String?
    var tagline: String?
    var description: String?
    var imageURL: String?

    
    init(from decoder: Decoder)
    {
        let container = try? decoder.container(keyedBy: Keys.self)
        name = try? container?.decode(String.self, forKey: .name)
        tagline = try? container?.decode(String.self, forKey: .tagline)
        description = try? container?.decode(String.self, forKey: .description)
        imageURL = try? container?.decode(String.self, forKey: .imageURL)
    }
}
