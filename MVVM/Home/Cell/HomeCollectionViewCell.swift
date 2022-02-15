//
//  HomeCollectionViewCell.swift
//  MVVM
//
//  Created by Ahmed Saeed on 2/4/22.
//  Copyright © 2022 Ahmed Saeed. All rights reserved.
//

import UIKit
import Kingfisher

class HomeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var ProductView: UIView!
    var cornerRadius: CGFloat = 5.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        img.layer.cornerRadius = 15.0
        img.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        // Apply rounded corners to contentView
        contentView.layer.cornerRadius = cornerRadius
        contentView.layer.masksToBounds = true
        
        // Set masks to bounds to false to avoid the shadow
        // from being clipped to the corner radius
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = false
        
        // Apply a shadow
        layer.shadowRadius = 8.0
        layer.shadowOpacity = 0.10
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 5)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Improve scrolling performance with an explicit shadowPath
        layer.shadowPath = UIBezierPath(
            roundedRect: bounds,
            cornerRadius: cornerRadius
            ).cgPath
    }
    /*    override func awakeFromNib() {
        super.awakeFromNib()
        ProductView.backgroundColor = UIColor.white
        contentView.backgroundColor = UIColor.white
        img.layer.cornerRadius = 15.0
        img.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    */
    
    
    func configure(Product: CatrogyModelDatum) {
        
        if let img = URL(string: Product.image ){
            DispatchQueue.main.async {
                
                self.img.kf.setImage(with: img)
                
            }
        }
    }
    
}
