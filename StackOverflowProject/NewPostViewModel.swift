//
//  NewPostViewModel.swift
//  StackOverflowProject
//
//  Created by dirtbag on 1/29/20.
//  Copyright © 2020 dirtbag. All rights reserved.
//

import UIKit

class NewPostViewModel {

    var previewQuestion: QuestionData?
    var urlBuilder = URLBuilder()
    
    func updatePreview(title: String, body: String, tags: String, updatedPreview: @escaping () -> Void) {
        
        if isQuestionDataValid(title, body, tags) {
            createNewQuestion(title, body, tags) {
                updatedPreview()
            }
        } else {
            // deal with errrors
            updatedPreview()
        }
    }
    
    func isQuestionDataValid(_ title: String, _ body: String, _ tags: String) -> Bool {
        // is title at least 15 chars
        
        // is boty at lease 30 chars
        
        // is at least one tag specified
        
        return false
    }
    
    private func createNewQuestion(_ title: String, _ body: String, _ tags: String, questionCreated: @escaping () -> Void) {
        
        let urlString = urlBuilder.createQuestion()
        
        print(urlString)
        guard var params = urlBuilder.newPostParams(title: title, body: body) else { return }
        params += "&tags=\(tags)"
        guard let paramData = params.data(using: .utf8) else { return }
        
        NetworkManager.shared.postData(urlString: urlString, params: paramData) { (data) in
                          
            print(String(data: data, encoding: .utf8)!)
            let questionParser = QuestionParser()
            questionParser.parse(data: data) { (questionItems) in
                if questionItems.items.count > 0 {
                    self.previewQuestion = questionItems.items[0]
                }
                questionCreated()
            }
        }
    }
}
