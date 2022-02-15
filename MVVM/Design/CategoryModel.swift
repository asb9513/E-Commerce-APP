//
//  CategoryModel.swift
//  MVVM
//
//  Created by Ahmed Saeed on 2/2/22.
//  Copyright © 2022 Ahmed Saeed. All rights reserved.
//

import Foundation
struct CatrogyModel: Codable {
    let status: Bool?
    let message: String?
    let data: CatrogyModelDataClass?
}

// MARK: - DataClass
struct CatrogyModelDataClass: Codable {
    let currentPage: Int?
    let data: [CatrogyModelDatum]?
    let firstPageURL: String?
    let from, lastPage: Int?
    let lastPageURL: String?
    let nextPageURL: String?
    let path: String?
    let perPage: Int?
    let prevPageURL: String?
    let to, total: Int?
    
    enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case data
        case firstPageURL = "first_page_url"
        case from
        case lastPage = "last_page"
        case lastPageURL = "last_page_url"
        case nextPageURL = "next_page_url"
        case path
        case perPage = "per_page"
        case prevPageURL = "prev_page_url"
        case to, total
    }
}

// MARK: - Datum
struct CatrogyModelDatum: Codable {
    let id: Int
    let name: String
    let image: String
}
