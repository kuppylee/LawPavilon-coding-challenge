//
//  SearchResultViewModel.swift
//  lawPavillonCodingChallenge
//
//  Created by Kuppylee on 02/02/2023.
//

import Foundation
import ProgressHUD



protocol SearchResultViewModelDelegate {
    func didReceiveGetSearchResultResponse(searchResultResponse: SearchResultResponse?, statusCode: Int)
}
class SearchResultViewModel {
    private var userDetails:[UsersDetails] = []
    var delegate: SearchResultViewModelDelegate?
    func getSearchResult(username: String,page: Int,perPage: Int, completion: @escaping () -> Void) {
        ProgressHUD.show()
        userDetails.removeAll()
        let searchResultFetcher = FetchSearchResult()
        searchResultFetcher.fetchSearchResult( page: page, perPage: perPage, username: username ) { searchResultData, statusCode in
            if statusCode == 200 {
                DispatchQueue.main.async { [weak self] in
                    self?.delegate?.didReceiveGetSearchResultResponse(searchResultResponse: searchResultData, statusCode: statusCode)
                    guard let searchResult = searchResultData?.items else {
                        return
                    }
                    guard let totalCount = searchResultData?.total_count else {
                        return
                    }
                    Utility.setPageCount(number: totalCount)
                    for i in 0..<searchResult.count {
                        let loginName = searchResult[i].login
                        let typeName = searchResult[i].type
                        let avatarImage = searchResult[i].avatar_url
                        self?.userDetails.append(UsersDetails(avatar: avatarImage ?? "", login: loginName, userType: typeName ?? ""))
                        
                        self?.userDetails =  self?.userDetails.sorted(by: {$0.login.localizedCapitalized < $1.login.localizedCapitalized}) ?? []
                    }
                    completion()
                    ProgressHUD.dismiss()
                }
            }
        }
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return  userDetails.count
    }
    func cellForRowsAt(indexPath: IndexPath) -> [UsersDetails] {
        return userDetails
    }
}

