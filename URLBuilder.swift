//
//  URLBuilder.swift
//  StackOverflowProject
//
//  Created by dirtbag on 1/11/20.
//  Copyright © 2020 dirtbag. All rights reserved.
//

import UIKit

class URLBuilder {

    let searchURL = "https://api.stackexchange.com/2.2/search?order=desc&sort=activity&site=stackoverflow&intitle="

    let answerURL = "https://api.stackexchange.com/2.2/search?order=desc&sort=activity&site=stackoverflow&intitle="

    func getSearchURL(searchTerm: String) -> String {
        
        let encodedString = searchTerm.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        return "\(searchURL)\(encodedString)"
    }
}
