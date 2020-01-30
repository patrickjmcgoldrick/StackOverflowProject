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
        //newPostView.previewButton.addTarget(self, action: #selector(btnActionPreview), for: .touchUpInside)
    }
    
    func btnActionNewPost(_ sender: Any) {
       
        let newPostViewController = NewPostViewController()
        self.navigationController?.show(newPostViewController, sender: self)
            //.pushViewController(newPostViewController, animated: true)
        //performSegue(withIdentifier: "toNewPost", sender: self)
    }
    
    func dateToInt(_ date: Date) -> Int {
        
        let timeInterval = date.timeIntervalSince1970
        return  Int(timeInterval)
    }
}
