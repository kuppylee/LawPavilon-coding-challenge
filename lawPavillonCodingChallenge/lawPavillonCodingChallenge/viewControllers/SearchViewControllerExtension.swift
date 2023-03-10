//
//  SearchViewControllerExtension.swift
//  lawPavillonCodingChallenge
//
//  Created by Kuppylee on 03/02/2023.
//

import Foundation
import UIKit

extension SearchViewController {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultViewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchResultTableView.dequeueReusableCell(withIdentifier: "SearchResultTableViewCell", for: indexPath) as! SearchResultTableViewCell
        let searchDetails = searchResultViewModel.cellForRowsAt(indexPath: indexPath)[indexPath.row]
        cell.selectionStyle = .none
        cell.userAvartar.kf.setImage(with: URL(string: "\(searchDetails.avatar)"))
        cell.username.text = searchDetails.login.localizedCapitalized
        cell.userType.text = searchDetails.userType.localizedCapitalized
        return cell
    }
    
//    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
//
//        }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if Utility.getPagesCount() > 9 {
            if indexPath.row == searchResultViewModel.numberOfRowsInSection(section: indexPath.section) - 1 {
                DispatchQueue.main.async { [weak self] in
                    self?.showTableViewfooterLoader()
                    self?.loadingIndicator.startAnimating()
                    if Utility.getPagesCount() <= self?.page ?? 1  {
                        self?.loadingIndicator.stopAnimating()
                    } else{
                        self?.perPage += 10
                        self?.searchResultViewModel.getSearchResult(username: self?.searchUserTextField.text ?? "", page: self?.page ?? 1, perPage: self?.perPage ?? 1) {
                            DispatchQueue.main.async { [self] in
                                self?.searchResultTableView.reloadData()
                                self?.loadingIndicator.stopAnimating()
                            }
                        }
                    }
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let userDetailsViewController = storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController {
            userDetailsViewController.avartarUrl = searchResultViewModel.cellForRowsAt(indexPath: indexPath)[indexPath.row].avatar
            userDetailsViewController.username = searchResultViewModel.cellForRowsAt(indexPath: indexPath)[indexPath.row].login.localizedCapitalized
            userDetailsViewController.userType = searchResultViewModel.cellForRowsAt(indexPath: indexPath)[indexPath.row].userType.localizedCapitalized
            navigationController?.pushViewController(userDetailsViewController, animated: true)
        }else{
            return
        }
    }
    
    func showTableViewfooterLoader() {
        loadingIndicator.color = .blue
        loadingIndicator.hidesWhenStopped = true
        searchResultTableView.tableFooterView = loadingIndicator
    }
}
