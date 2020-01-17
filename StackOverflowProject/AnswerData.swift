//
//  AnswerData.swift
//  StackOverflowProject
//
//  Created by dirtbag on 1/16/20.
//  Copyright © 2020 dirtbag. All rights reserved.
//

import Foundation

struct AnswerData: Codable {
    var items: [Answer]
    var has_more: Bool
    var quota_max: Int
    var quota_remaining: Int
}

struct Answer: Codable {
    var is_accepted: Bool
    var creation_date: Int
    var title: String
    var body: String
    var score: Int
}
