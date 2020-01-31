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
        self.navigationController?
            .pushViewController(NewPostViewController(), animated: true)
    }
}
