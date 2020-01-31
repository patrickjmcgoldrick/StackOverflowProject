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
    
    var viewModel = QuestionDetailViewModel()
    var questionView = QuestionDetailView()
   
    // MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        questionView.viewModel = viewModel
        
        viewModel.loadQuestion() {
            DispatchQueue.main.async {
                self.questionView.tableView.reloadData()
            }
        }
    }
}
