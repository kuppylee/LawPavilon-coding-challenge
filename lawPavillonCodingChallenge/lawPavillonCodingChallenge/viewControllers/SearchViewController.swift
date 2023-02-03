//
//  ViewController.swift
//  lawPavillonCodingChallenge
//
//  Created by Kuppylee on 01/02/2023.
//

import UIKit
import Kingfisher


class SearchViewController: UIViewController , UITableViewDataSource , UITableViewDelegate {
    
    var searchResultViewModel = SearchResultViewModel()
    var page : Int = 1
    var perPage : Int = 10
    let loadingIndicator = UIActivityIndicatorView(style: .medium)

    @IBOutlet weak var searchUserTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    @IBOutlet weak var searchResultDescription: UILabel!
    
    @IBOutlet weak var searchResultTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchResultTableView.dataSource = self
        searchResultTableView.delegate = self
        searchResultDescription.text = ""
        navigationItem.title = "Search for GitHub users"
        navigationItem.backButtonTitle = "Back"

    }
    
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        guard let username = searchUserTextField.text else {return}
        if username == "" {
                searchResultDescription.text = ""
        }
        else {
            searchResultViewModel.getSearchResult(username: username, page: page, perPage: perPage) {
                DispatchQueue.main.async { [weak self] in
                    self?.searchResultDescription.text = "Search result for: \(username)"
                    self?.searchResultTableView.reloadData()
                }
            }
        }
    }
    
}


