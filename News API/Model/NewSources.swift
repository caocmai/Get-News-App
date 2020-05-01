//
//  Model.swift
//  News API
//
//  Created by Cao Mai on 4/27/20.
//  Copyright © 2020 Make School. All rights reserved.
//

import Foundation


public struct Source: Decodable {
    let id: String?
    let name: String?
}

public struct Article: Decodable {
    let source: Source
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let content: String?
}

public struct ArticleList: Decodable{
    public var articles: [Article]
}


public struct AllNewsSources: Decodable {
    let sources: [NewsSource]
}

public struct NewsSource: Decodable {
    let id: String?
    let name: String?
    let category: String?
}
