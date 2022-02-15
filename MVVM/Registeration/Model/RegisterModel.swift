//
//  File1.swift
//  MVVM
//
//  Created by Ahmed Saeed on 2/1/22.
//  Copyright © 2022 Ahmed Saeed. All rights reserved.
//

import Foundation
// MARK: - RegisterModel
struct RegisterModel: Codable {
    let status: Bool?
    let message: String?
    let data: RegisterModelDataClass?
}

// MARK: - DataClass
struct RegisterModelDataClass: Codable {
    let name, phone, email: String?
    let id: Int?
    let image: String?
    let token: String?
}
