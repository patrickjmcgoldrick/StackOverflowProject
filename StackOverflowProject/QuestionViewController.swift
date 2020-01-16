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
        print(urlString)
        
        NetworkManager.shared.getData(urlString: urlString) { (data) in
            
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
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

// MARK: Table View Data Source
extension QuestionViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
        if let post = question, let body = post.body {
            print("Body: \(body)")
            if indexPath.row == 0 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionCell") as? QuestionTableViewCell
                    else { return UITableViewCell() }
                print("setting up label")
                cell.lblBody.text = body.html2String
                return cell
            } else {
                
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionWebCell") as? QuestionTableViewCell
                    else { return UITableViewCell() }
                print("setting up webview")

                cell.webView.loadHTMLString(body, baseURL: URL(string: "https://api.stackexchange.com/")!)
                return cell
            }
        }
        return UITableViewCell()
    }
}
