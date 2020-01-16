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
    
    var questionId: Int?
    var question: Question?
    
    // MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        
        let urlBuilder = URLBuilder()
        guard let questionId = questionId else { return }
        let urlString = urlBuilder.getQuestionURL(questionId: questionId)
        
        NetworkManager.shared.getData(urlString: urlString) { (data) in
            
            print(String(data: data, encoding: .utf8)!)
            
            let parser = SearchParser()
            parser.parse(data: data) { (questionData) in
                
                if questionData.items.count > 0 {
                    self.populateUI(questionData.items[0])
                }
            }
        }
    }
    
    func populateUI(_ question: Question) {
        self.question = question
    }
}

// MARK: Table View Data Source
extension QuestionViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionCell") as? QuestionTableViewCell
            else { return UITableViewCell() }
        
        if let post = question {
            cell.lblBody.text = post.body
            print(post.body)
        }
        
        return cell
    }
}
