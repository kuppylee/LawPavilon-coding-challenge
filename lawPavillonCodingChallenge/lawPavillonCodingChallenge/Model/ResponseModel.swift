//
//  Model.swift
//  lawPavillonCodingChallenge
//
//  Created by Kuppylee on 02/02/2023.
//

import Foundation

struct SearchResultResponse: Codable {
    let total_count: Int
    let incomplete_results: Bool
    let items: [Items]
}

struct Items : Codable {
    let login : String
    let avatar_url: String?
    let type: String?
}
