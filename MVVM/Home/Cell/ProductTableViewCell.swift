//
//  ProductTableViewCell.swift
//  MVVM
//
//  Created by Ahmed Saeed on 2/10/22.
//  Copyright © 2022 Ahmed Saeed. All rights reserved.
//

import UIKit
import Kingfisher
class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var ProductName: UILabel!
    var cornerRadius: CGFloat = 5.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        productImage.layer.cornerRadius = 40.0
        productImage.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
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
    
    func configure(Product: Datum) {
        
        if let img = URL(string: Product.image ){
            DispatchQueue.main.async {
                
                self.productImage.kf.setImage(with: img)
                
            }
        }
    }
    
}
