//
//  QuestionViewController.swift
//  StackOverflowProject
//
//  Created by dirtbag on 1/12/20.
//  Copyright © 2020 dirtbag. All rights reserved.
//

import UIKit

class QuestionDetailViewController: UIViewController {
    
    var questionView = QuestionDetailView()
    var viewModel = QuestionDetailViewModel()
   
    // MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        questionView.viewModel = viewModel
        view = questionView
        
        viewModel.loadQuestion() {
            DispatchQueue.main.async {
                self.questionView.tableView.reloadData()
            }
        }
    }
}
