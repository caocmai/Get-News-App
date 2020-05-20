//
//  Model.swift
//  News API
//
//  Created by Cao Mai on 4/27/20.
//  Copyright © 2020 Make School. All rights reserved.
//

import Foundation

public struct NewsSource: Decodable, Hashable {
    let id: String?
    let name: String?
    let category: String?
}

public struct AllNewsSources: Decodable {
    let sources: [NewsSource]
}
