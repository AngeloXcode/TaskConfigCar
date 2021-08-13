//
//  productProduct.swift
//  Task
//
//  Created by Mac on 13/08/2021.
//

import Foundation
struct ProductDetials : Codable {
    let category : String?
    let name : String?
    let price : productPrice?
    enum CodingKeys: String, CodingKey {
        case category = "category"
        case name = "name"
        case price = "price"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        category = try values.decodeIfPresent(String.self, forKey: .category)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        if let priceP = try values.decodeIfPresent(productPrice.self, forKey: .price){
            price = priceP
        }else{
            price = nil
        }
        
    }
    
}
