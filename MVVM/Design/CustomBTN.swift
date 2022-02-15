//
//  CustomBTN.swift
//  MVVM
//
//  Created by Ahmed Saeed on 2/1/22.
//  Copyright © 2022 Ahmed Saeed. All rights reserved.
//

import Foundation
import UIKit
/*
@IBDesignable
class RoundedButton: UIButton {
    
    @IBInspectable var shadowOffSetWidth: CGFloat = 0.5
    @IBInspectable var shadowOffSetHeight: CGFloat = 0.5
    @IBInspectable var shadowOpacity: CGFloat = 0.5
    @IBInspectable var shadowColor = UIColor.gray
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInit()
    }
    
    override func prepareForInterfaceBuilder() {
        sharedInit()
    }
    
    func sharedInit() {
        refreshCorners(value: cornerRadius)
        refreshBorderColor(color: borderColor.cgColor)
        refreshBorder(width: borderWidth)
    }
    
    func refreshBorder(width: CGFloat) {
        layer.borderWidth = width
    }
    
    func refreshBorderColor(color : CGColor) {
        layer.borderColor = color
    }
    
    func refreshCorners(value: CGFloat) {
        layer.cornerRadius = value
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = CGSize(width: shadowOffSetWidth, height: shadowOffSetHeight)
        layer.shadowOpacity = Float(shadowOpacity)
    }
    
    @IBInspectable var cornerRadius: CGFloat = 17 {
        didSet {
            refreshCorners(value: cornerRadius)
        }
    }
    
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            refreshBorder(width: borderWidth)
        }
    }
    
    @IBInspectable var borderColor: UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) {
        didSet {
            refreshBorderColor(color: borderColor.cgColor)
        }
    }
    
}
*/
