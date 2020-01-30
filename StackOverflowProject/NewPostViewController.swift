//
//  NewPostViewController.swift
//  StackOverflowProject
//
//  Created by dirtbag on 1/26/20.
//  Copyright © 2020 dirtbag. All rights reserved.
//

import UIKit

class NewPostViewController: UIViewController {

    let newPostView = NewPostView()
    let viewModel = NewPostViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        newPostView.viewModel = viewModel
        view = newPostView
        newPostView.previewButton.addTarget(self, action: #selector(btnActionPreview), for: .touchUpInside)
    }
    
    // MARK: Update Preview
    @objc
    func btnActionPreview() {
        
        // TODO: should be validating here
        guard let title = newPostView.tfTitle.text else { return }
        guard let body = newPostView.taBody.text else { return }
        let tags = "testing"
        
        viewModel.updatePreview(title: title, body: body, tags: tags) {
            DispatchQueue.main.async {
                self.newPostView.previewTable.reloadData()
            }
        }
    }
    
    // MARK: Create New Post
    @objc
    func btnActionPost() {
    }
    

}

