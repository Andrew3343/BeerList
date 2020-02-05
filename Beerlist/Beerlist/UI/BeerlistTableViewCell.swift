//
//  BeerlistTableViewCell.swift
//  Beerlist
//
//  Created by Andrew on 30.01.2020.
//  Copyright © 2020 Andrew. All rights reserved.
//

import UIKit

final class BeerlistTableViewCell: UITableViewCell {
    
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var taglineLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var previewImageView: UIImageView!
    
    private var currentImageURL: String?
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        selectionStyle = .none
        previewImageView.image = UIImage(named: "image_placeholder")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        previewImageView.image = UIImage(named: "image_placeholder")
        currentImageURL = nil
    }
    
    func setupWith(beerItem: BeerItem, imageSupply: ImageSupply) {
        
        
        titleLabel.text = beerItem.name
        taglineLabel.text = beerItem.tagline
        descriptionLabel.text = beerItem.description
        currentImageURL = beerItem.imageURL
        
        guard let imageURL = beerItem.imageURL else {
            return
        }
        
        imageSupply.getImage(url: imageURL, completion: { [weak self](result) in
            if case .success(let image) = result, self?.currentImageURL == imageURL {
                if Thread.isMainThread {
                    self?.previewImageView.image = image
                } else {
                    DispatchQueue.main.async {
                        self?.previewImageView.image = image
                    }
                }
            }
        })
    }
}
