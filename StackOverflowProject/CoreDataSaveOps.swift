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
    
    func saveQuestion(question: QuestionData) {
        
        let questionManagedObject = Question(context: context)
        questionManagedObject.question_id = Int32(question.question_id)
        questionManagedObject.votedUp = question.upvoted
        questionManagedObject.votedDown = question.downvoted
        questionManagedObject.score = Int32(question.score)
        questionManagedObject.title = question.title
        questionManagedObject.body = question.body
        
        coreDataManager.saveContext(context: context)
    }
    func saveAnswers(answers: [AnswerData]) {
        
        var answerObjects = [Answer]()
        for answer in answers {
            let answerManagedObject = Answer(context: context)
            answerManagedObject.question_id = Int32(answer.question_id)
            answerManagedObject.answer_id = Int32(answer.answer_id)
            answerManagedObject.votedUp = answer.upvoted
            answerManagedObject.votedDown = answer.downvoted
            answerManagedObject.score = Int32(answer.score)
            answerManagedObject.body = answer.body
            answerObjects.append(answerManagedObject)
        }
        coreDataManager.saveContext(context: context)
    }
}
