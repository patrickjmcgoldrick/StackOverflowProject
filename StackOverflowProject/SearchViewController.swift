//
//  ViewController.swift
//  StackOverflowProject
//
//  Created by dirtbag on 1/11/20.
//  Copyright © 2020 dirtbag. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
        
    var searchView = SearchView()
    var viewModel = SearchViewModel()
    
    let addQuestionBarButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem()
        barButton.title = "Add"
        barButton.style = .plain
        return barButton
    }()

    // MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
                
        searchView.viewModel = viewModel
        view = searchView
        
        let newPostButton = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(btnActionNewPost))
        self.navigationItem.rightBarButtonItem = newPostButton
    }
    
    @objc
    func btnActionNewPost() {
       
        print("Press bar button item")
        
        let newPostViewController = NewPostViewController()
        self.navigationController?//.show(newPostViewController, sender: self)
            .pushViewController(newPostViewController, animated: true)
    }
    
    func dateToInt(_ date: Date) -> Int {
        
        let timeInterval = date.timeIntervalSince1970
        return  Int(timeInterval)
    }
}
