//
//  AnswerTableViewCell.swift
//  StackOverflowProject
//
//  Created by dirtbag on 1/16/20.
//  Copyright © 2020 dirtbag. All rights reserved.
//

import UIKit

class AnswerTableViewCell: UITableViewCell {

    @IBOutlet weak var lblBody: UILabel!
   
    @IBOutlet weak var imgAccepted: UIImageView!
    
    @IBOutlet weak var lblScore: UILabel!
    
    @IBOutlet weak var btnAnswerUpvote: UIButton!
    
    @IBOutlet weak var btnAnswerDownvote: UIButton!
    
    var updateDelegate: UpdateDelegate?
    
    // tags are being set to row + 1 for Answers
    // to distingush them from the question
    @IBAction private func btnActionUpvote(_ sender: Any) {
        if let delegate = updateDelegate {
            delegate.updateUpvote(row: tag)
        }
    }
    
    // tags are being set to row + 1 for Answers
    // to distingush them from the question
    @IBAction private func btnActionDownvote(_ sender: Any) {
        if let delegate = updateDelegate {
            delegate.updateDownvote(row: tag)
        }
    }
}
