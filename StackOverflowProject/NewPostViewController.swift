//
//  NewPostViewController.swift
//  StackOverflowProject
//
//  Created by dirtbag on 1/26/20.
//  Copyright © 2020 dirtbag. All rights reserved.
//

import UIKit

class NewPostViewController: UIViewController {

    @IBOutlet weak var tfTitle: UITextField!
    
    @IBOutlet weak var taBody: UITextView!
    
    @IBOutlet weak var previewTable: UITableView!
    
    var previewQuestion: QuestionData?
    var urlBuilder = URLBuilder()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        previewTable.dataSource = self
    }
    
    // MARK: Update Preview
    @IBAction func btnActionPreview(_ sender: Any) {
        guard let title = tfTitle.text else { return }
        guard let body = taBody.text else { return }
        
        if !title.isEmpty && !body.isEmpty {
            createNewQuestion(title, body)
        }
    }
    
    // MARK: Create New Post
    @IBAction func btnActionPost(_ sender: Any) {
    }
    
    private func createNewQuestion(_ title: String, _ body: String) {
        
        let urlString = urlBuilder.createQuestion()
        
        print(urlString)
        guard var params = urlBuilder.newPostParams(title: title, body: body) else { return }
        params += "&tags=testing"
        guard let paramData = params.data(using: .utf8) else { return }
        
        NetworkManager.shared.postData(urlString: urlString, params: paramData) { (data) in
                          
            print(String(data: data, encoding: .utf8)!)
            let questionParser = QuestionParser()
            questionParser.parse(data: data) { (questionItems) in
                if questionItems.items.count > 0 {
                    self.previewQuestion = questionItems.items[0]
                    DispatchQueue.main.async {
                        self.previewTable.reloadData()
                    }
                }
            }
        }
    }
}

// MARK: Table Data Source
extension NewPostViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let question = previewQuestion {
            return question.title
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let question = previewQuestion {
            return 1
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let question = previewQuestion {
            let cell = UITableViewCell()
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.text = question.body
            return cell
        } else {
            let cell = UITableViewCell()
            cell.textLabel?.text = "No preview yet."
            return cell
        }
    }
}
