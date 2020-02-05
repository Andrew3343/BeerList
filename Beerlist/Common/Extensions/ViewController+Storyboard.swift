//
//  ViewController+Storyboard.swift
//  Beerlist
//
//  Created by Andrew on 30.01.2020.
//  Copyright © 2020 Andrew. All rights reserved.
//

import UIKit

extension UIViewController {
    
    class var storyboardID: String {
        
        return "\(self)"
    }
    
    static func instantiateFromStoryboard(storyboard: BeerlistStoryboard) -> Self {
        
        return storyboard.viewController(viewControllerClass: self)
    }
}
