//
//  CategoryCell.swift
//  Task
//
//  Created by Mac on 13/08/2021.
//

import UIKit

class CategoryCell: UITableViewCell,ReusableCell{
    // MARK: - Properties Cell
    @IBOutlet weak var sectionButton: UIButton!
    @IBOutlet weak var arrowImage: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    // MARK: - set name for cateory 
    var categoryName : String! {
        didSet {
            nameLbl.text = categoryName
        }
    }
    // MARK: - change image when state for isExpanded changed
    var isExpanded : Bool = false {
        didSet{
            self.arrowImage.image = isExpanded ? UIImage(systemName: "arrow.right.circle.fill") : UIImage(systemName: "arrow.down.circle.fill")
        }
    }
    
    
    
}
