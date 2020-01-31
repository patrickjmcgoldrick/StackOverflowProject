//
//  CoreDataSaveOps.swift
//  CoreDataProject
//
//  Created by dirtbag on 12/3/19.
//  Copyright © 2019 dirtbag. All rights reserved.
//

import CoreData

class CoreDataSaveOps {
    let coreDataManager = CoreDataManager.shared
    let context = CoreDataManager.shared.mainContext
    static let shared = CoreDataSaveOps()
    
    private init() {}
    
    func saveQuestion(questionObject: QuestionModel) {
        
        let questionManagedObject = Question(context: context)
        questionManagedObject.question_id = questionObject.question_id
        questionManagedObject.votedUp = questionObject.votedUp
        questionManagedObject.votedDown = questionObject.votedDown
        questionManagedObject.score = questionObject.score
        questionManagedObject.body = questionObject.body
        
        coreDataManager.saveContext(context: context)
    }
    func saveAnswer(answerObject: AnswerModel) {
        
        let answerManagedObject = Answer(context: context)
        answerManagedObject.question_id = answerObject.question_id
        answerManagedObject.answer_id = answerObject.answer_id
        answerManagedObject.votedUp = answerObject.votedUp
        answerManagedObject.votedDown = answerObject.votedDown
        answerManagedObject.score = answerObject.score
        answerManagedObject.body = answerObject.body

        coreDataManager.saveContext(context: context)
    }
}
