//
//  productRootClass.swift
//  Task
//
//  Created by Mac on 13/08/2021.
//

import Foundation

struct Product : Codable {
    let body : [ProductBody]?
    enum CodingKeys: String, CodingKey {
        case body = "body"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        body = try values.decodeIfPresent([ProductBody].self, forKey: .body)
    }
}
