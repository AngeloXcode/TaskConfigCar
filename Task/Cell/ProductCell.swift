//
//  ProductCell.swift
//  Task
//
//  Created by Mac on 13/08/2021.
//

import UIKit
// MARK: - Product cell
class ProductCell: UITableViewCell,ReusableCell {
    // MARK: - Properties cell
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var brandLbl: UILabel!
    @IBOutlet weak var imgProduct: UIImageView!
    // MARK: - fill the propery cell from ProductInfo structure 
    var productItem : ProductInfo! {
        didSet {
            nameLbl.text = productItem.productName
            priceLbl.text = "€\(productItem.productPrice ?? 0)°"
            brandLbl.text  = productItem.productCategory
            
        }
    }
    
    
}
