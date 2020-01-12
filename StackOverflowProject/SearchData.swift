//
//  SearchData.swift
//  StackOverflowProject
//
//  Created by dirtbag on 1/11/20.
//  Copyright © 2020 dirtbag. All rights reserved.
//

import Foundation

struct SearchData: Codable {
    var items: [Result]?
}

struct Result: Codable {
    //var question_id: String?
    var title: String?
}
