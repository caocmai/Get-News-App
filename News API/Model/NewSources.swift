//
//  Model.swift
//  News API
//
//  Created by Cao Mai on 4/27/20.
//  Copyright © 2020 Make School. All rights reserved.
//

import Foundation

struct NewsSources: Decodable{
    let status: String
    var sources : [Source]
}

struct Source: Decodable {
    let id: String
    let category: String
}
