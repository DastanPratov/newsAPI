//
//  NewsModelAPI.swift
//  NewsApp
//
//  Created by Dastan on 12/2/23.
//

import Foundation

struct NewsModelAPI: Decodable {
    var articles: [Arcticle]
}

struct Arcticle: Decodable {
    var title: String
    var description: String
    var urlToImage: String?
}
