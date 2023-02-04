//
//  SearchResultViewModel.swift
//  lawPavillonCodingChallenge
//
//  Created by Kuppylee on 02/02/2023.
//

import Foundation


class SearchResultViewModel {
    private var userDetails:[UsersDetails] = []
    func getSearchResult(username: String,page: Int,perPage: Int, completion: @escaping () -> Void) {
        userDetails.removeAll()
        let searchResultFetcher = FetchSearchResult()
        searchResultFetcher.fetchSearchResult( page: page, perPage: perPage, username: username ) { searchResultData, statusCode in
            if statusCode == 200 {
                DispatchQueue.main.async { [weak self] in
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
                        print("This is the user details \(String(describing: self?.userDetails))")
                        print("This is the page count \(Utility.getPagesCount())")
                    }
                    completion()
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

