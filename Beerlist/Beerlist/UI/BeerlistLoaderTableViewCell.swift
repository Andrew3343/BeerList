//
//  BeerlistLoaderTableViewCell.swift
//  MovieList
//
//  Created by Andrew on 30.01.2020.
//  Copyright © 2020 Andrew. All rights reserved.
//

import UIKit

final class BeerlistLoaderTableViewCell: UITableViewCell {
    
    @IBOutlet private var activityIndicatorView: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func startAnimating() {
        activityIndicatorView.startAnimating()
    }
    
    func stopAnimating() {
        activityIndicatorView.stopAnimating()
    }
}
