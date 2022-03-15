//
//  Constants.swift
//  Newsify
//
//  Created by Daksh K on 15/03/22.
//

import Foundation
struct Constants {
    
    static let API_KEY = "aed8a18b934f4f26ada81f57b774c0cb"
    
    struct Urls {
        static func urlNews(countryCode: String) -> URL {
            return URL(string: "https://newsapi.org/v2/top-headlines?country=\(countryCode)&apiKey=\(API_KEY)")!
        }
    }
    
}
