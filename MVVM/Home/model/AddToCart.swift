//
//  AddToCart.swift
//  MVVM
//
//  Created by Ahmed Saeed on 2/11/22.
//  Copyright © 2022 Ahmed Saeed. All rights reserved.
//

import Foundation
struct AddCartModel: Codable {
    let status: Bool?
    let message: String?
    let data: AddCartModelDataClass?
}

// MARK: - DataClass
struct AddCartModelDataClass: Codable {
    let id: Int?
    let product: AddCartModelProduct?
}

// MARK: - Product
struct AddCartModelProduct: Codable {
    let id, price, oldPrice, discount: Int?
    let image: String?
    
    enum CodingKeys: String, CodingKey {
        case id, price
        case oldPrice = "old_price"
        case discount, image
    }
}

