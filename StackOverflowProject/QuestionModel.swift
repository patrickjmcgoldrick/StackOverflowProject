//
//  QuestionModel.swift
//  StackOverflowProject
//
//  Created by dirtbag on 1/22/20.
//  Copyright © 2020 dirtbag. All rights reserved.
//

import Foundation

struct QuestionModel {
    var question_id: Int32
    var votedUp: Bool
    var votedDown: Bool
    var score: Int32
    var body: String
}
