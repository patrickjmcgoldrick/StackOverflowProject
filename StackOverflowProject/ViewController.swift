//
//  ViewController.swift
//  StackOverflowProject
//
//  Created by dirtbag on 1/11/20.
//  Copyright © 2020 dirtbag. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var searchView: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    let urlBuilder = URLBuilder()
    var questions = [Question]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        let url = urlBuilder.getSearchURL(searchTerm: "swift push notifications")
        
        let network = NetworkController()
        network.loadData(urlString: url) { (data) in
                        
            print(String(data: data, encoding: .utf8)!)
            
            let parser = SearchParser()
            parser.parse(data: data) { (searchData) in
                
                self.questions = searchData.items
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return questions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell") as? UITableViewCell else { return UITableViewCell() }
        
        let question = questions[indexPath.row]
        cell.textLabel?.text = question.title
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                    
        performSegue(withIdentifier: "toAnswers", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 
        if let destination = segue.destination as? QuestionViewController {
            
            if let row = tableView.indexPathForSelectedRow?.row {
            
                destination.questionURL = questions[row].link
            }
        }
    }
}
