//
//  CoreDataDeleteOps.swift
//  CoreDataClassDemo
//
//  Created by dirtbag on 12/3/19.
//  Copyright © 2019 dirtbag. All rights reserved.
//

import CoreData

class CoreDataDeleteOps {
    private let coreDataManager = CoreDataManager.shared
    private let context = CoreDataManager.shared.mainContext
    static let shared = CoreDataDeleteOps()
    
    func deleteAllData() {
        let questions = CoreDataFetchOps.shared.getAllQuestions()
        print(questions.count)
        
        if questions.count != 0 {
            for question in questions {
                deleteBy(questionId: question.question_id)
            }
        }
    }
    
    func deleteBy(questionId: Int32) {
        
        // find related answers, and delete them
        let fetchRequest: NSFetchRequest<Answer> = Answer.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "question_id = %d", questionId)
        let answers = coreDataManager.fetchObjects(fetchRequest: fetchRequest, context: context)
        if answers.count != 0 {
            coreDataManager.batchDelete(objects: answers, context: context)
        }
        
        // find the question and delete it.
        let questionFetchRequest: NSFetchRequest<Question> = Question.fetchRequest()
        questionFetchRequest.predicate = NSPredicate(format: "question_id = %d", questionId)
        let question = coreDataManager.fetchObjects(fetchRequest: fetchRequest, context: context)
        if question.count != 0 {
            coreDataManager.batchDelete(objects: question, context: context)
        }
    }
}
