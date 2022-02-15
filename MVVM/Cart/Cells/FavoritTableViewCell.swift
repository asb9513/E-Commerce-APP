//
//  FavoritTableViewCell.swift
//  MVVM
//
//  Created by Ahmed Saeed on 2/11/22.
//  Copyright © 2022 Ahmed Saeed. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher
class FavoritTableViewCell: UITableViewCell {
    @IBOutlet weak var favImage: UIImageView!
    @IBOutlet weak var favName: UILabel!
    @IBOutlet weak var delete: UIButton!
    //  @IBOutlet weak var price: UILabel!
    
    var cornerRadius: CGFloat = 5.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        favImage.layer.cornerRadius = 15.0
        favImage.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
      delete.layer.cornerRadius = 15
        delete.layer.masksToBounds = true
        // Apply rounded corners to contentView
        contentView.layer.cornerRadius = cornerRadius
        contentView.layer.masksToBounds = true
        
        // Set masks to bounds to false to avoid the shadow
        // from being clipped to the corner radius
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = false
        
        // Apply a shadow
        layer.shadowRadius = 20.0
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
    
    func configure(Product: ShowCartModelProduct) {
        
        if let img = URL(string: Product.image ){
            DispatchQueue.main.async {
                
                self.favImage.kf.setImage(with: img)
                
            }
        }
    }
    
  
}
