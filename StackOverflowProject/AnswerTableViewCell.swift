//
//  AnswerTableViewCell.swift
//  StackOverflowProject
//
//  Created by dirtbag on 1/16/20.
//  Copyright © 2020 dirtbag. All rights reserved.
//

import UIKit

class AnswerTableViewCell: PostTableViewCell {
        
    var imgAccepted: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        addSubview(imgAccepted)
        
        imgAccepted.topAnchor.constraint(equalTo: btnDownVote.bottomAnchor).isActive = true
        imgAccepted.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor).isActive = true
        imgAccepted.widthAnchor.constraint(equalToConstant: 48).isActive = true
        imgAccepted.heightAnchor.constraint(equalToConstant: 48).isActive = true
    }
    
    // tags are being set to row + 1 for Answers
    // to distingush them from the question
    @objc
    func btnActionUpvote(_ sender: Any) {
        if let delegate = updateDelegate {
            delegate.updateUpvote(row: tag)
        }
    }
    
    // tags are being set to row + 1 for Answers
    // to distingush them from the question
    @objc
    func btnActionDownvote(_ sender: Any) {
        if let delegate = updateDelegate {
            delegate.updateDownvote(row: tag)
        }
    }
}
