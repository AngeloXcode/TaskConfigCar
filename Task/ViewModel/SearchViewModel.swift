//
//  SearchViewModel.swift
//  Task
//
//  Created by Mac on 13/08/2021.
//

import Foundation
import Combine
import UIKit
// MARK: - Product structure to handle model
struct ProductInfo {
    var productName        : String?
    var productCategory    : String?
    var productPrice       : Int?
}

// MARK: - SearchViewModel for read json file and search inside product list
class SearchViewModel : NSObject {
    // MARK: - Enumeration for all view model state
    enum State{
        case isLoading
        case failed(String)
        case loaded
        case scroll
        case insertRows([IndexPath])
        case deleteRows([IndexPath])
    }
    
    // MARK: - Properties
    var productDict : [String? : [Task.ProductInfo]]!          // dictionary that keep all products
    var currentProductDict : [String? : [Task.ProductInfo]]!   // dictionary that keep  products after search
    @Published var state : State = .isLoading                 // make object of Enumeration and set this Observer Object By Published
    private var subscriptions = Set<AnyCancellable>()         // subscriptions to remove objects from memeory
    var hiddenSections = Set<Int>()                            // set to add selected Section
    
    override init() {
        super.init()
        self.ReadJsonFile()
    }
    // MARK: - Start read json file
    fileprivate func ReadJsonFile() {
        RequestLayer.ReadJsonFile().sink(receiveCompletion: { (completion) in
            switch completion {
            case .failure(let error):
                self.state = .failed(error.errorDescription!) //make object state is failed if any error was happend
                break
            case .finished:
                break
            }
        }, receiveValue: { (result) in
            if let productList = result.body {
                var productArray = [ProductInfo]()
                self.appendProductList(productList, &productArray)
                self.productDict = self.generateDictionary(productArray: productArray)
                if  self.productDict.count > 0 {
                    self.currentProductDict = self.productDict
                    self.state = .loaded
                }else{
                    self.state = .failed(EmptyProduct)    //display message empty product list
                }
            }else{
                self.state = .failed(ErrorParser)      //make object state is failed
            }
            
        }).store(in: &subscriptions)
    }
    // MARK: - Append main Array for product list
    fileprivate func appendProductList(_ productList: [ProductBody], _ productArray: inout [ProductInfo]) {
        for product in productList{
            let productName     = product.product?.name
            let productCategory = product.product?.category
            let productPrice    = (product.product?.price?.discountPercent == 0) ? product.product?.price?.originalPrice : product.product?.price?.discountPercent
            productArray.append(ProductInfo(productName: productName, productCategory: productCategory, productPrice: productPrice))
        }
    }
    
    // MARK: - to handle section and cell we need to using Dictionary, inside this Dictionary keys will be section and values will be cell
    private func generateDictionary(productArray :  [ProductInfo]) -> [String? : [Task.ProductInfo]]{
      // this will be generate Dictionary and keys will be the name of category
      return  Dictionary(grouping:productArray, by: { (element: ProductInfo) in
           return element.productCategory
       })
    }
    // MARK: - in collapse method will be keep section inside hiddenSections set and search inside it , if user select section and the state for this section is unselect, remove cell under section and make animation to remove it . if user select section and the state for this section is select, append cell under this section and make animation to append it again .
    public func collapse(section:Int){
        //get all cell under the section
        func indexPathsForSection() -> [IndexPath] {
            var indexPaths = [IndexPath]()
            for row in 0..<Array(self.currentProductDict)[section].value.count {
                indexPaths.append(IndexPath(row: row,section: section))
            }
            return indexPaths
        }
        //if section selected before remove it from set
        if self.hiddenSections.contains(section) {
            self.hiddenSections.remove(section)
            self.state = .insertRows(indexPathsForSection())  // change the state for observer set to make animation in View controller
        } else {
            //if section unselected before insert it inside set 
            self.hiddenSections.insert(section)
            self.state = .deleteRows(indexPathsForSection())  // change the state for observer set to make animation in View controller
        }
        
    }
}



extension SearchViewModel : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.state = .scroll
    }
}


