//
//  QuestionDetailViewModel.swift
//  StackOverflowProject
//
//  Created by dirtbag on 1/30/20.
//  Copyright © 2020 dirtbag. All rights reserved.
//

import Foundation

class QuestionDetailViewModel {
    
    let urlBuilder = URLBuilder()
    var questionId: Int?
    var question: QuestionData?
    var answers = [AnswerData]()
    
    func loadQuestion(qustionLoaded: @escaping () -> Void) {
        guard let questionId = questionId else { return }
        let urlString = urlBuilder.getQuestionAndAnswersURL(questionId: questionId)
        
        NetworkManager.shared.getData(urlString: urlString) { (data) in
            
            let parser = QuestionParser()
            parser.parse(data: data) { (questionItems) in
                
                print(String(data: data, encoding: .utf8)!)
                
                if questionItems.items.count > 0 {
                    self.question = questionItems.items[0]
                    if let newAnswers = questionItems.items[0].answers {
                        self.answers = newAnswers
                    }
                    
                    qustionLoaded()
                }
            }
        }
    }

    func updateQuestionData(_ urlString: String, questionUpdated: @escaping () -> Void) {
        print(urlString)
        let data = urlBuilder.authPostParams().data(using: .utf8)
        guard let paramData = data else { return }
        
        NetworkManager.shared.postData(urlString: urlString, params: paramData) { (data) in
                          
            print(String(data: data, encoding: .utf8)!)
            let questionParser = QuestionParser()
            questionParser.parse(data: data) { (questionItems) in
                if questionItems.items.count > 0 {
                    self.question = questionItems.items[0]
                    questionUpdated()
                }
            }
        }
    }
    
    func updateAnswerData(_ urlString: String, row: Int, answerUpdated: @escaping () -> Void) {
        print(urlString)
        let data = urlBuilder.authPostParams().data(using: .utf8)
        guard let paramData = data else { return }
        
        NetworkManager.shared.postData(urlString: urlString, params: paramData) { (data) in
                          
            print(String(data: data, encoding: .utf8)!)
            let answerParser = AnswerParser()
            answerParser.parse(data: data) { (answerItems) in
                if answerItems.items.count > 0 {
                    self.answers[row] = answerItems.items[0]
                    answerUpdated()
                }
            }
        }
    }
}
