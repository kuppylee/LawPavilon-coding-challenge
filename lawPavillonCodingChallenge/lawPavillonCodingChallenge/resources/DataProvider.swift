//
//  DataProvider.swift
//  lawPavillonCodingChallenge
//
//  Created by Kuppylee on 02/02/2023.
//

import Foundation



struct FetchSearchResult {
    func fetchSearchResult(page: Int, perPage: Int, username: String, completionHandler: @escaping (_ result: SearchResultResponse?,_ statusCode:Int) -> Void) {
        let serviceProvider = ServiceProvider()
        let searchResultUrl = ApiEndpoint.userEndpoint + "?q=\(username)&page=\(page)&per_page=\(perPage)"
        guard let url = URL(string: searchResultUrl) else {return}
        do {
            serviceProvider.fetchAPIDataAndStatusCode(requestURL: url, resultType: SearchResultResponse.self) { result, statusCode in
                completionHandler(result,statusCode)
            }
        }
    }
}
