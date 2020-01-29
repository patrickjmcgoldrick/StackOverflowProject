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
    
    let answerURL = "https://api.stackexchange.com/2.2/answers/"

    
    // MARK: LOGIN - OAUTH 2.0
    // build up OAUTH 2.0 Login URL for StackOverflow
    func getLoginPageURL() -> String {
        
        let client_id = "client_id=\(APIKeys.StackOverflow.client_id)&key=\(APIKeys.StackOverflow.key)"
        let scope = "&scope=read_inbox,write_access,private_info"

        let redirect_uri = "&redirect_uri= https://stackexchange.com/oauth/login_success"
        let paramString = client_id + scope + redirect_uri
        // encode url params
        let encodedString = paramString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        return "\(loginPageURL)?\(encodedString)"
    }
    
    // MARK: Search
    func getSearchURL(searchTerm: String) -> String {
        
        guard let encodedString = searchTerm.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return "" }
        return "\(searchURL)\(encodedString)&\(authGetParams())"
    }
    
    // MARK: Questions
    func createQuestion() -> String {
        return "\(questionURL)add"
    }
    
    func getQuestionAndAnswersURL(questionId: Int) -> String {
        return "\(questionURL)\(questionId)/?filter=!FnhX5sXiIs.YeksGT.C*q60hqb&site=stackoverflow&\(authGetParams())"
    }
    
    func getQuestionOnly(questionId: Int) -> String {
       return  "\(questionURL)\(questionId)/?filter=!9Z(-wwYGT&site=stackoverflow&\(authGetParams())"
    }
    
    // MARK: Favorite
    func favoriteQuestion(_ questionId: Int) -> String {
        return ("\(questionURL)\(questionId)/favorite")
    }
    
    func undoFavoriteQuestion(_ questionId: Int) -> String {
        return ("\(questionURL)\(questionId)/favorite/undo")
    }
    
    // MARK: Upvote Quesiton
    func upVoteQuestion(_ questionId: Int) -> String {
        return "\(questionURL)\(questionId)/upvote"
    }
    
    func undoUpVoteQuestion(_ questionId: Int) -> String {
        return "\(questionURL)\(questionId)/upvote/undo"
    }

    // MARK: Downvote Question
    func downVoteQuestion(_ questionId: Int) -> String {
        return "\(questionURL)\(questionId)/downvote"
    }
    
    func undoDownVoteQuestion(_ questionId: Int) -> String {
        return "\(questionURL)\(questionId)/downvote/undo"
    }
    
    // MARK: Answers
    func getAnswersURL(questionId: Int) -> String {
        return "\(questionURL)\(questionId)/answers?filter=!b1MMEAHHviRpJX&site=stackoverflow&\(authGetParams())"
    }

    // MARK: Upvote Answer
    func upVoteAnswer(_ answerId: Int) -> String {
        return "\(answerURL)\(answerId)/upvote"
    }
    
    func undoUpVoteAnswer(_ answerId: Int) -> String {
        return "\(answerURL)\(answerId)/upvote/undo"
    }

    // MARK: Downvote Answer
    func downVoteAnswer(_ answerId: Int) -> String {
        return "\(answerURL)\(answerId)/downvote"
    }
    
    func undoDownVoteAnswer(_ answerId: Int) -> String {
        return "\(answerURL)\(answerId)/downvote/undo"
    }

    // MARK: Authorized Params Helper
    private func authGetParams() -> String {
        return "key=\(APIKeys.StackOverflow.key)&access_token=\(Session.shared.accessToken)"
    }
    
    func authPostParams() -> String {
        return "site=stackoverflow&filter=!FnhX5sXiIs.YeksPCkGy9NDGT6&key=\(APIKeys.StackOverflow.key)&access_token=\(Session.shared.accessToken)"
    }
    
    func newPostParams(title: String, body: String) -> String? {
        let params = "&title=\(title)&body=\(body)"
        if let encoded = params.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
            
            return authPostParams() + encoded + "&preview=true"
        }
        return nil
    }
}
