//
//  QuestionViewController.swift
//  StackOverflowProject
//
//  Created by dirtbag on 1/12/20.
//  Copyright © 2020 dirtbag. All rights reserved.
//

import UIKit
import WebKit

class QuestionViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let urlBuilder = URLBuilder()
    var questionId: Int?
    var question: QuestionData?
    var answers = [AnswerData]()
    
    // MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
    
        loadQuestion()
    }
    
    func loadQuestion() {
        guard let questionId = questionId else { return }
        let urlString = urlBuilder.getQuestionURL(questionId: questionId)
        
        NetworkManager.shared.getData(urlString: urlString) { (data) in
            
            let parser = QuestionParser()
            parser.parse(data: data) { (questionItems) in
                
                print(String(data: data, encoding: .utf8)!)
                
                if questionItems.items.count > 0 {
                    self.question = questionItems.items[0]
                    if let newAnswers =  questionItems.items[0].answers {
                        self.answers = newAnswers
                    }
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
}

// MARK: Table View Data Source
extension QuestionViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if answers.count == 0 {
            return 1
        } else {
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            if let post = question {
                return post.title
            } else {
                return "Question:"
            }
        } else {
            return "\(answers.count) Answers"
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        } else {
            return answers.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
        if indexPath.section == 0 {
            return getQuestionCell(indexPath: indexPath)
        } else {
            return getAnswerCell(indexPath: indexPath)
        }
    }
    
    // MARK: Question Cell
    func getQuestionCell(indexPath: IndexPath) -> UITableViewCell {
        
        guard let post = question else { return UITableViewCell() }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionCell") as? QuestionTableViewCell
            else { return UITableViewCell() }
        cell.tag = 0
        cell.updateDelegate = self
        cell.lblBody.text = post.body.html2String
        cell.lblScore.text = post.score.description
        print("Answers in Question: \(post.answers?.count)")
        return cell
    }

    // MARK: Answer Cell
    func getAnswerCell(indexPath: IndexPath) -> UITableViewCell {
                
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AnswerCell") as? AnswerTableViewCell
            else { return UITableViewCell() }
        
        let answer = answers[indexPath.row]
        // add one (1) to tag so we know which are answers
        cell.tag = indexPath.row + 1
        cell.lblBody.text = answer.body
        cell.lblScore.text = answer.score.description
        
        if answer.is_accepted {
            cell.imgAccepted.image = UIImage(imageLiteralResourceName: "checkmark")
        } else {
            cell.imgAccepted.image = nil
        }

        return cell
    }
}

extension QuestionViewController: UpdateDelegate {
    
    func updateUpvote(row: Int, newStatus: Bool) {
        //
    }
    
    func updateDownvote(row: Int, newStatus: Bool) {
        //
    }
    
    // must be row 0, Question
    func updateFavorite() {
        guard let favorite = question?.favorited else { return }
        guard let questionId = question?.question_id else { return }
        var tempUrlString: String?
        if favorite {
            tempUrlString = urlBuilder.undoFavoriteQuestion(questionId)
        } else {
            tempUrlString = urlBuilder.favoriteQuestion(questionId)
        }
        guard let urlString = tempUrlString else { return }
        print(urlString)
        let data = urlBuilder.authPostParams().data(using: .utf8)
        guard let paramData = data else { return }
        
        NetworkManager.shared.postData(urlString: urlString, params: paramData) { (data) in
                          
            print(String(data: data, encoding: .utf8)!)
        }
    }
}
