//
//  URLBuilder.swift
//  StackOverflowProject
//
//  Created by dirtbag on 1/11/20.
//  Copyright © 2020 dirtbag. All rights reserved.
//

import UIKit

class URLBuilder {

    let loginPageURL = "https://stackoverflow.com/oauth/dialog"
    
    let actualLoginURL = "https://stackoverflow.com/users/login"
    
    let searchURL = "https://api.stackexchange.com/2.2/search?order=desc&sort=activity&site=stackoverflow&intitle="

    let answerURL = "https://api.stackexchange.com/2.2/search?order=desc&sort=activity&site=stackoverflow&intitle="

    
    // build up OAUTH 2.0 Login URL for StackOverflow
    func getLoginPageURL(clientId: String) -> String {
        
        let client_id = "client_id=\(clientId)"
        let scope = "&scope=read_inbox,private_info"
        
        //let scope = "&scope=read_inbox,write_access,private_info"

        let redirect_uri = "&redirect_uri= https://stackexchange.com/oauth/login_success"
        let paramString = client_id + scope + redirect_uri
        // encode url params
        let encodedString = paramString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        return "\(loginPageURL)?\(encodedString)"
    }
    
    
    
    // build up OAUTH 2.0 Login URL for StackOverflow
    func getActualLoginURL(clientId: String) -> String {
        
        let client_id = "client_id=\(clientId)"
        let scope = "&scope=read_inbox,private_info"
        
        //let scope = "&scope=read_inbox,write_access,private_info"

        let redirect_uri = "&redirect_uri= https://stackexchange.com/oauth/login_success"
        
        let paramString = client_id + scope + redirect_uri
        // encode url params
        let encodedString = paramString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        return "\(actualLoginURL)?\(encodedString)"
    }
    
    func getSearchURL(searchTerm: String) -> String {
        
        let encodedString = searchTerm.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        return "\(searchURL)\(encodedString)"
    }
}
