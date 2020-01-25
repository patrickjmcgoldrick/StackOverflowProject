//
//  UpdateDelegate.swift
//  StackOverflowProject
//
//  Created by dirtbag on 1/23/20.
//  Copyright © 2020 dirtbag. All rights reserved.
//

import Foundation

protocol UpdateDelegate {

    func updateUpvote(row: Int)
    
    func updateDownvote(row: Int)
    
    // only the Question can be favorited
    // so no need to specify row
    func updateFavorite()
}
