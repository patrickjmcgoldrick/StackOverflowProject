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
    var question: Question?
    var answers = [Answer]()
    
    // MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
    
        loadQuestion()
        loadAnswers()
    }
    
    func loadQuestion() {
        guard let questionId = questionId else { return }
        let urlString = urlBuilder.getQuestionURL(questionId: questionId)
        
        NetworkManager.shared.getData(urlString: urlString) { (data) in
            
            let parser = SearchParser()
            parser.parse(data: data) { (questionData) in
                
                if questionData.items.count > 0 {
                    self.question = questionData.items[0]
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
    
    func loadAnswers() {
        guard let questionId = questionId else { return }
        let urlString = urlBuilder.getAnswersURL(questionId: questionId)
        NetworkManager.shared.getData(urlString: urlString) { (data) in
            
            let parser = AnswerParser()
            parser.parse(data: data) { (answerData) in
                
                if answerData.items.count > 0 {

                    self.answers = answerData.items
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
    
    func getQuestionCell(indexPath: IndexPath) -> UITableViewCell {
        
        guard let post = question, let body = post.body else { return UITableViewCell() }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionCell") as? QuestionTableViewCell
            else { return UITableViewCell() }
        cell.lblBody.text = body.html2String
        cell.lblScore.text = post.score.description
        return cell
    }

    func getAnswerCell(indexPath: IndexPath) -> UITableViewCell {
                
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AnswerCell") as? AnswerTableViewCell
            else { return UITableViewCell() }
        
        let answer = answers[indexPath.row]
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
