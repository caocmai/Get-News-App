//
//  Model.swift
//  News API
//
//  Created by Cao Mai on 4/27/20.
//  Copyright © 2020 Make School. All rights reserved.
//

import Foundation

public struct NewsSources: Decodable{
    let status: String
    var sources : [Source]
}

public struct Source: Decodable {
    let id: String
    let category: String
}

public struct Article: Codable {
    let author: String?
    let title: String?
    let description: String?
    let url: URL?
    let urlToImage: URL?
    let content: String?
}

public struct ArticleList: Codable{
    public var articles: [Article]
}
