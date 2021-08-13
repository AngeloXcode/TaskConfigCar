//
//  ViewController.swift
//  Task
//
//  Created by Mac on 13/08/2021.
//

import UIKit
import Combine

class ProductVC: UIViewController {
    // MARK: - Properties for View controller
    @IBOutlet weak var productTableView: UITableView! {
        didSet {
            //add xib to tableview
            self.productTableView?.register(UINib(nibName: CategoryCell.identifier, bundle: nil), forCellReuseIdentifier: CategoryCell.identifier)
        }
    }
    @IBOutlet weak var searchBar: UISearchBar!
    fileprivate var viewModel : SearchViewModel! // create object from SearchViewModel
    private var cancellables: [AnyCancellable] = []    // create object from AnyCancellable to remove any object from memory after finish
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()  // start create object SearchViewModel from  to read and search inside product list
        setupSearchBar()
    }
    
    private func setupSearchBar(){
        self.navigationItem.hidesSearchBarWhenScrolling = true
        self.searchBar.delegate = self.viewModel // add delegate to model
    }
    // MARK: - start ViewModel method
    func initViewModel() {
        self.viewModel = SearchViewModel() //initialization of object from Search View Model
        self.viewModel.$state.sink { (state) in
            switch state {
            case .isLoading:
                Spinner.start() // start spinner
                break
            case .loaded:
                Spinner.stop()
                self.reloadTableView()  // dismiss spinner
                break
            case .failed(_):
                Spinner.stop() // dismiss spinner
            case .scroll:
                self.dismissKeyboard() // when scolling dismiss keyboard
                break
            case .insertRows(let indexPathsForSection):
                self.insertRowsIntoTableView(indexPathsForSection) // when collapse add indexpath and cell to tableview
            case .deleteRows(let indexPathsForSection):
                self.removeRowsFromTableView(indexPathsForSection) // when collapse remove indexpath and cell from tableview
            }
        }.store(in: &cancellables)
    }
    // MARK: - set datasource and delegate for tableview and reload tableview again
    fileprivate func reloadTableView() {
        self.productTableView.dataSource = self.viewModel
        self.productTableView.delegate   = self.viewModel
        self.productTableView.reloadData()
    }
    // MARK: - insert rows when collapse was expanded
    fileprivate func insertRowsIntoTableView(_ indexPathsForSection: ([IndexPath])) {
        self.productTableView.dataSource = self.viewModel
        self.productTableView.delegate   = self.viewModel
        self.productTableView.insertRows(at: indexPathsForSection,with: .fade)
        self.productTableView.reloadData()
    }
    // MARK: - remove rows when collapse was unexpanded
    fileprivate func removeRowsFromTableView(_ indexPathsForSection: ([IndexPath])) {
        self.productTableView.dataSource = self.viewModel
        self.productTableView.delegate   = self.viewModel
        self.productTableView.beginUpdates()
        self.productTableView.deleteRows(at: indexPathsForSection,with: .fade)
        self.productTableView.endUpdates()
        self.productTableView.reloadData()
    }

}
extension ProductVC {
    // MARK: -  hidden statue bar 
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}





