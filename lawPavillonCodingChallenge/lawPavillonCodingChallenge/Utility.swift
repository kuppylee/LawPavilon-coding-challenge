//
//  Utility.swift
//  lawPavillonCodingChallenge
//
//  Created by Kuppylee on 02/02/2023.
//

import Foundation

struct Utility {

    static func setPageCount(number: Int) {
        UserDefaults.standard.setValue(number, forKey: "pageCount")
    }
    
    static func getPagesCount() -> Int {
        return UserDefaults.standard.integer(forKey: "pageCount")
    }
    
}
