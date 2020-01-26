//
//  SearchData.swift
//  StackOverflowProject
//
//  Created by dirtbag on 1/11/20.
//  Copyright © 2020 dirtbag. All rights reserved.
//

import Foundation

struct SearchItems: Codable {
    var items: [SearchData]
    var has_more: Bool
    var quota_max: Int
    var quota_remaining: Int
}

struct SearchData: Codable {
    var question_id: Int
    var title: String
}
