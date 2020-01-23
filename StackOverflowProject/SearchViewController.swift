//
//  ViewController.swift
//  StackOverflowProject
//
//  Created by dirtbag on 1/11/20.
//  Copyright © 2020 dirtbag. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchView: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    let urlBuilder = URLBuilder()
    var questions = [SearchData]()
    
    // MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        searchView.delegate = self
        
        /* //let network = NetworkManager.shared
        NetworkManager.getRecentQuestions(fromDate: dateToInt( Date()), toDate: dateToInt(Date()) + 86400) { (date, error) in
            
        } */
    }
    
    func dateToInt(_ date: Date) -> Int {
        
        let timeInterval = date.timeIntervalSince1970
        return  Int(timeInterval)
    }
}

// MARK: Table View Data Source
extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return questions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell") else { return UITableViewCell() }
        
        let question = questions[indexPath.row]
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = question.title
        
        return cell
    }
}

// MARK: Table View Delegate
extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                    
        performSegue(withIdentifier: "toAnswers", sender: nil)
    }
    
    // MARK: VC Transition Prep
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 
        if let destination = segue.destination as? QuestionViewController {
            
            if let row = tableView.indexPathForSelectedRow?.row {
            
                destination.questionId = questions[row].question_id
            }
        }
    }
}

// MARK: Search Bar Delegate
extension SearchViewController: UISearchBarDelegate {
    /*
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
       
        if searchText.count == 0 {
             questions = [QuestionData]()
             return
         }
    }
*/
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if let searchText = searchBar.searchTextField.text {
            search(searchText)
        }
        
        searchBar.resignFirstResponder()
    }
    
    func search(_ searchText: String) {
        
       let url = urlBuilder.getSearchURL(searchTerm: searchText)
        let network = NetworkManager.shared
        network.getData(urlString: url) { (data) in
                                 
            let parser = SearchParser()
            parser.parse(data: data) { (searchData) in
                
                self.questions = searchData.items
                
                print("Quota: \(searchData.quota_remaining)")
                print(self.questions.count)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
}
