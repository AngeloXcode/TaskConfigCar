//
//  File.swift
//  Task
//
//  Created by Mac on 13/08/2021.
//

import Foundation
import UIKit
// MARK: - extension for handle Tableview
extension SearchViewModel : UITableViewDataSource,UITableViewDelegate {

 // cell for product name
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if  let productCell = tableView.dequeueReusableCell(withIdentifier:ProductCell.identifier, for: indexPath) as? ProductCell {
            productCell.productItem = Array(self.currentProductDict)[indexPath.section].value[indexPath.row]
            return productCell
            
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // when select section return 0 for number of cell
        if self.hiddenSections.contains(section) {
            return 0
        }
        return Array(self.currentProductDict)[section].value.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let cell = tableView.dequeueReusableCell(withIdentifier:CategoryCell.identifier) as? CategoryCell {
            if let categoryName = Array(self.currentProductDict)[section].key {
                cell.categoryName       =  categoryName
                cell.sectionButton.tag  = section
                // change image when select cell
                if self.hiddenSections.contains(section){
                    cell.isExpanded = true
                }else{
                    cell.isExpanded = false
                }
                cell.sectionButton.addTarget(self, action: #selector(self.hideSection), for: .touchUpInside)
            }
            return cell
        }
        return nil
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.currentProductDict.count
    }
    
    func tableView(_ tableView: UITableView,
                   heightForHeaderInSection section: Int) -> CGFloat{
        return CGFloat(HeightSection)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  CGFloat(HeightCell)
        
    }
    // MARK: - event for make Collapse
    @objc
    private func hideSection(sender: UIButton) {
        let section = sender.tag
        self.collapse(section: section)
    }
    
   
}
