//
//  File.swift
//  Task
//
//  Created by Mac on 13/08/2021.
//

import Foundation
import UIKit
// MARK: - extension for handle search text field
extension SearchViewModel : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.state = .isLoading // when start typing, set state for observer for is loading
        guard !searchBar.text!.isEmpty else {
            self.currentProductDict = self.productDict   // when textfield is empty, add all product list to currentProductDict
            self.state = .loaded   // when start typing, set state for observer for is loading
            return
        }
        // start search if write more than one char
        if searchBar.text!.count > 1 {
            // using filter to search inside productDict model
            self.currentProductDict = self.productDict.filter({ product in
                guard let text = searchBar.text else{ return false}
                return product.value.contains(where: { productInfo in
                    let productItem = productInfo.productName?.lowercased()
                    let categoryName = productInfo.productCategory?.lowercased()
                    return (productItem!.contains(text.lowercased())) || (categoryName!.contains(text.lowercased()))
                })
            })
            self.state = .loaded  // when finsih search , set state for observer for is loaded
        }
    }
}
