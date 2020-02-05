//
//  Color.swift
//  MovieList
//
//  Created by Andrew on 30.01.2020.
//  Copyright © 2020 Andrew. All rights reserved.
//

import UIKit

enum Color {
    
    enum Loader {
        
        static let cover = Colors.Black.blackTransparent
    }
    
    enum Button {
        
        static let border = Colors.Purple.lightPurple
    }
    
}

private enum Colors {
    
    enum Black {
        
        static let blackTransparent = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
    }
    
    enum Purple {
        
        static let lightPurple = UIColor(red: 204/255, green: 0, blue: 204/255, alpha: 0.5)
    }
}
