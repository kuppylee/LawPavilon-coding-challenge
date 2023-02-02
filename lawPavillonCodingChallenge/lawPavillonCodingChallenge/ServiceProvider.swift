//
//  ServiceProvider.swift
//  lawPavillonCodingChallenge
//
//  Created by Kuppylee on 02/02/2023.
//

import Foundation

struct ServiceProvider {
    
    func fetchAPIDataAndStatusCode<T: Decodable>(requestURL: URL, resultType: T.Type, completion: @escaping (_ result: T?,_ statusCode: Int) -> Void) {
        var requestURL = URLRequest(url: requestURL, cachePolicy: URLRequest.CachePolicy.reloadIgnoringLocalCacheData, timeoutInterval: 60)
        URLCache.shared.removeCachedResponse(for: requestURL)
        requestURL.httpMethod = "get"
        requestURL.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        requestURL.addValue("application/json", forHTTPHeaderField: "Accept")
        URLSession.shared.dataTask(with: requestURL) { (responseData, serviceURLResponse, error) in
            guard let serviceResponse  = serviceURLResponse as? HTTPURLResponse else { return  }
            if (error == nil && responseData != nil && responseData?.count != 0) {
                let decoder = JSONDecoder()
                do {
                    if serviceResponse.statusCode ==  200 {
                        let result = try decoder.decode(T.self, from: responseData!)
                        completion(result, serviceResponse.statusCode)
                    }
                    if serviceResponse.statusCode ==  403 {
                        let result = try decoder.decode(T.self, from: responseData!)
                        completion(result, serviceResponse.statusCode)
                    }
                    if serviceResponse.statusCode ==  503 {
                        let result = try decoder.decode(T.self, from: responseData!)
                        completion(result, serviceResponse.statusCode)
                    }
                } catch let error{
                    debugPrint("error occured while decoding = \(error.localizedDescription)")
                }
            }
        }.resume()
    }
}

