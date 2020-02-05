//
//  UITableViewCell+Nib.swift
//  Beerlist
//
//  Created by Andrew on 30.01.2020.
//  Copyright © 2020 Andrew. All rights reserved.
//

import UIKit

extension UITableViewCell {
    
    static var nibName: String {
        String(describing: self)
    }
    
    static var reuseIdentifier: String {
        String(describing: self)
    }
}
