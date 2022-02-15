//
//  DeletModel.swift
//  MVVM
//
//  Created by Ahmed Saeed on 2/13/22.
//  Copyright © 2022 Ahmed Saeed. All rights reserved.
//

import Foundation
struct DeletCartModel: Codable {
    let status: Bool
    let message: String
    let data: DeletCartModelDataClass
}

// MARK: - DataClass
struct DeletCartModelDataClass: Codable {
    let id: Int
    let product: Product
}

// MARK: - Product
struct Product: Codable {
    let id, price, oldPrice, discount: Int
    let image: String
    
    enum CodingKeys: String, CodingKey {
        case id, price
        case oldPrice = "old_price"
        case discount, image
    }
}
