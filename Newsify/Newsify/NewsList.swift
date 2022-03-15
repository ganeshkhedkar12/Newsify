//
//  NewsList.swift
//  Newsify
//
//  Created by Daksh K on 14/03/22.
//

import Foundation

struct NewsList: Decodable {
    let articles: [News]
}

struct News: Decodable {
    let title: String
    let description: String?
}

//aed8a18b934f4f26ada81f57b774c0cb
