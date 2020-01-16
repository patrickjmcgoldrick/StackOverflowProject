//
//  SearchData.swift
//  StackOverflowProject
//
//  Created by dirtbag on 1/11/20.
//  Copyright © 2020 dirtbag. All rights reserved.
//

import Foundation

struct SearchData: Codable {
    var items: [Question]
    var has_more: Bool
    var quota_max: Int
    var quota_remaining: Int
}

struct Question: Codable {
    var question_id: Int
    var accepted_answer_id: Int?
    var title: String
    var link: String
    var body: String?
}
