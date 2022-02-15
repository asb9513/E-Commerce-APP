//import Foundation
// MARK: - ShowCartModel
import Foundation

// MARK: - ShowCartModel
struct ShowCartModel: Codable {
    let status: Bool
    let message: JSONNull?
    let data: ShowCartModelDataClass
}

// MARK: - DataClass
struct ShowCartModelDataClass: Codable {
    let currentPage: Int
    let data: [ShowCartModelDatum]
    let firstPageURL: String
    let from, lastPage: Int
    let lastPageURL: String
    let nextPageURL: JSONNull?
    let path: String
    let perPage: Int
    let prevPageURL: JSONNull?
    let to, total: Int
    
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
struct ShowCartModelDatum: Codable {
    let id: Int
    let product: ShowCartModelProduct
}

// MARK: - Product
struct ShowCartModelProduct: Codable {
    let id: Int
    let price, oldPrice: Double
    let discount: Int
    let image: String
    let name, productDescription: String
    
    enum CodingKeys: String, CodingKey {
        case id, price
        case oldPrice = "old_price"
        case discount, image, name
        case productDescription = "description"
    }
}

// MARK: - Encode/decode helpers

