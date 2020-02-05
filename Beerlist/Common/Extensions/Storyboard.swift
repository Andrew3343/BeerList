//
//  Storyboard.swift
//  Beerlist
//
//  Created by Andrew on 30.01.2020.
//  Copyright © 2020 Andrew. All rights reserved.
//

import UIKit

enum BeerlistStoryboard: String {
    
    case Beerlist
    
    var instance: UIStoryboard {
        
        return UIStoryboard(name: self.rawValue, bundle: nil)
    }
    
    func viewController<T: UIViewController>(viewControllerClass: T.Type) -> T {
        
        let storyboardID = viewControllerClass.storyboardID
        return instance.instantiateViewController(identifier: storyboardID) as! T
    }
    
    func initialViewController() -> UIViewController? {
        
        return instance.instantiateInitialViewController()
    }
}
