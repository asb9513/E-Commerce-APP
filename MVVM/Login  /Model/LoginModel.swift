//
//  loginModel.swift
//  MVVM
//
//  Created by Ahmed Saeed on 2/1/22.
//  Copyright © 2022 Ahmed Saeed. All rights reserved.
//

import Foundation
struct LoginModel: Codable {
    let status: Bool?
    let message: String?
    let data: LoginModelDataClass?
}

// MARK: - DataClass
struct LoginModelDataClass: Codable {
    let id: Int?
    let name, email, phone: String?
    let image: String?
    let points: Int?
    let credit: Double?
    let token: String?
}

