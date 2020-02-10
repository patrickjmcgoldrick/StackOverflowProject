//
//  AnswerItems.swift
//  StackOverflowProject
//
//  Created by dirtbag on 1/16/20.
//  Copyright © 2020 dirtbag. All rights reserved.
//

import Foundation

struct AnswerItems: Codable {
    var items: [AnswerData]
    var has_more: Bool
    var quota_max: Int
    var quota_remaining: Int
}

struct AnswerData: Codable {
    var question_id: Int
    var answer_id: Int
    var is_accepted: Bool
    var creation_date: Int
    var body: String
    var score: Int
    var upvoted: Bool
    var downvoted: Bool
}
