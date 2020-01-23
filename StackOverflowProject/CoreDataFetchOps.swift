//
//  CoreDataFetchOps.swift
//  CoreDataClassDemo
//
//  Created by dirtbag on 12/3/19.
//  Copyright © 2019 dirtbag. All rights reserved.
//

import CoreData

class CoreDataFetchOps {
    
    private let coreDataManager = CoreDataManager.shared
    private let context = CoreDataManager.shared.mainContext
    static let shared = CoreDataFetchOps()
    
    private init() {}
    
    /// Get all Questions
    func getAllQuestions() -> [Question] {
        let fetchRequest: NSFetchRequest<Question> = Question.fetchRequest()
        return coreDataManager.fetchObjects(fetchRequest: fetchRequest, context: context)
    }
    
    /// Gets Answers from Question id
    func getAnswersFromQuestion(questionId: Int32) -> [Answer] {
        let fetchRequest: NSFetchRequest<Answer> = Answer.fetchRequest()
        return coreDataManager.fetchObjects(fetchRequest: fetchRequest, context: context)
    }
    
    func getQuestion(questionId: Int32) -> [Question] {
        let fetchRequest: NSFetchRequest<Question> = Question.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "question_id=%d", questionId)
        return coreDataManager.fetchObjects(fetchRequest: fetchRequest, context: context)
    }
}
