//
//  productPrice.swift
//  Task
//
//  Created by Mac on 13/08/2021.
//

import Foundation
struct productPrice : Codable {
    let discountPercent : Int?
    let originalPrice : Int?
    
    enum CodingKeys: String, CodingKey {
        case discountPercent = "discount_percent"
        case originalPrice = "original_price"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        originalPrice = try values.decodeIfPresent(Int.self, forKey: .originalPrice)
        if let discount = try values.decodeIfPresent(Int.self, forKey: .discountPercent){
            discountPercent = discount
        }else{
            discountPercent = 0
        }
    }
    
}
