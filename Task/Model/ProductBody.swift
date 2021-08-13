//
//  productBody.swift
//  Task
//
//  Created by Mac on 13/08/2021.
//

import Foundation
struct ProductBody : Codable {
    let product : ProductDetials?
    enum CodingKeys: String, CodingKey {
        case product = "Product"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        if let productDetials = try values.decodeIfPresent(ProductDetials.self, forKey: .product){
            product = productDetials
        }else{
            product = nil
        }
        
    }
}
