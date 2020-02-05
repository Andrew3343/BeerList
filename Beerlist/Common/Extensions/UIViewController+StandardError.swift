//
//  UIViewController+StandardError.swift
//  Beerlist
//
//  Created by Andrew on 30.01.2020.
//  Copyright © 2020 Andrew. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showStandardError(name: String, description: String) {
        
        let controller = UIAlertController.init(title: name, message: description, preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(controller, animated: true)
    }
}
