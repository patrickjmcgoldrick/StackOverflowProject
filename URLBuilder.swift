//
//  URLBuilder.swift
//  StackOverflowProject
//
//  Created by dirtbag on 1/11/20.
//  Copyright © 2020 dirtbag. All rights reserved.
//

import UIKit

class URLBuilder {

    // MARK: Base URLs
    let loginPageURL = "https://stackoverflow.com/oauth/dialog"
    
    let actualLoginURL = "https://stackoverflow.com/users/login"
    
    let searchURL = "https://api.stackexchange.com/2.2/search?order=desc&sort=activity&site=stackoverflow&intitle="

    let questionURL = "https://api.stackexchange.com/2.2/questions/" 
    
    let answerURL = "https://api.stackexchange.com/2.2/search?order=desc&sort=activity&site=stackoverflow&intitle="

    
    // MARK: functions LOGIN URLs
    // build up OAUTH 2.0 Login URL for StackOverflow
    func getLoginPageURL() -> String {
        
        let client_id = "client_id=\(APIKeys.StackOverflow.client_id)"
        let scope = "&scope=read_inbox,private_info"
        
        //let scope = "&scope=read_inbox,write_access,private_info"

        let redirect_uri = "&redirect_uri= https://stackexchange.com/oauth/login_success"
        let paramString = client_id + scope + redirect_uri
        // encode url params
        let encodedString = paramString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        return "\(loginPageURL)?\(encodedString)"
    }
    
    // MARK: Data URLs
    func getSearchURL(searchTerm: String) -> String {
        
        guard let encodedString = searchTerm.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return "" }
        return "\(searchURL)\(encodedString)\(generateAuthorizationParams())"
    }
    
    func getQuestionURL(questionId: Int) -> String {
        return "\(questionURL)\(questionId)/?filter=!9Z(-wwYGT&site=stackoverflow\(generateAuthorizationParams())"
    }
    
    // MARK: Authorized Params Helper
    func generateAuthorizationParams() -> String {
        return "&client_id=\(APIKeys.StackOverflow.client_id)&key=\(APIKeys.StackOverflow.key)&access_token=\(Session.shared.accessToken)"
    }
}
