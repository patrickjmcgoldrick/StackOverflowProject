//
//  NewPostView.swift
//  StackOverflowProject
//
//  Created by dirtbag on 1/29/20.
//  Copyright © 2020 dirtbag. All rights reserved.
//

import UIKit

class NewPostView: UIView {

    var viewModel: NewPostViewModel?
        
    var tfTitle: UITextField = {
        var textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Your Title here..."
        textField.backgroundColor = .white
        return textField
    }()
   
    var taBody: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda."
        
        return textView
    }()
   
    var previewTable: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var previewButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Preview", for: .normal)
        return button
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
        backgroundColor = .systemTeal
        addSubview(tfTitle)
        addSubview(taBody)
        addSubview(previewButton)
        addSubview(previewTable)
        
        previewTable.dataSource = self
        
        tfTitle.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 24).isActive = true
        tfTitle.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        tfTitle.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 8).isActive = true
        
        taBody.topAnchor.constraint(equalTo: tfTitle.bottomAnchor, constant: 10).isActive = true
        
        taBody.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        taBody.rightAnchor.constraint(equalTo: rightAnchor, constant: 8).isActive = true
        taBody.heightAnchor.constraint(equalToConstant: 234).isActive = true

        previewButton.topAnchor.constraint(equalTo: taBody.bottomAnchor, constant: 24).isActive = true
        previewButton.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
        
        previewTable.topAnchor.constraint(equalTo: previewButton.bottomAnchor, constant: 24).isActive = true
        previewTable.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        previewTable.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        previewTable.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}

// MARK: Table Data Source
extension NewPostView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let question = viewModel?.previewQuestion {
            return question.title
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (viewModel?.previewQuestion) != nil {
            return 1
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let question = viewModel?.previewQuestion {
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
