//
//  SearchView.swift
//  StackOverflowProject
//
//  Created by dirtbag on 1/29/20.
//  Copyright © 2020 dirtbag. All rights reserved.
//

import UIKit

class SearchView: UIView {
    
    var viewModel: SearchViewModel?
    
    var searchBar: UISearchBar = {
        let searchbar = UISearchBar()
        searchbar.translatesAutoresizingMaskIntoConstraints = false
        return searchbar
    }()
    
    var tableView: UITableView = {
        let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.backgroundColor = .systemTeal
        return tableview
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        assertionFailure("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(searchBar)
        addSubview(tableView)
        
        searchBar.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        
        searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}

// MARK: Table View Data Source
extension SearchView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel?.questions.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        guard let question = viewModel?.questions[indexPath.row] else { return UITableViewCell() }
        
        let cell = UITableViewCell()
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = question.title
        print("title: \(question.title) at index: \(indexPath.row)")
        return cell
    }
}

// MARK: Table View Delegate
extension SearchView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                    
        //performSegue(withIdentifier: "toAnswers", sender: nil)
    }
    
    /*
    // MARK: VC Transition Prep
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 
        if let destination = segue.destination as? QuestionViewController {
            
            if let row = tableView.indexPathForSelectedRow?.row {
            
                destination.questionId = questions[row].question_id
            }
        }
    }
 */
}

// MARK: Search Bar Delegate
extension SearchView: UISearchBarDelegate {
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
            viewModel?.search(searchText, searchCompleted: {
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            })
        }
        
        searchBar.resignFirstResponder()
    }
}
