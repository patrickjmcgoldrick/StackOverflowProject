//
//  Session.swift
//  StackOverflowProject
//
//  Created by dirtbag on 1/15/20.
//  Copyright © 2020 dirtbag. All rights reserved.
//

import Foundation

/**
 * Global Variables related to access to StackOverflow website.
 */
class Session {
    
    static let shared = Session()
    
    private init() {}
    
    var accessToken = ""
}
