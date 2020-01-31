//
//  QuestionTableViewCell.swift
//  StackOverflowProject
//
//  Created by dirtbag on 1/15/20.
//  Copyright © 2020 dirtbag. All rights reserved.
//

import UIKit

class QuestionTableViewCell: PostTableViewCell {
    
    var btnFavorited: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
            
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        addSubview(btnFavorited)
        
        btnFavorited.topAnchor.constraint(equalTo: btnDownVote.bottomAnchor).isActive = true
        btnFavorited.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor).isActive = true
        btnFavorited.widthAnchor.constraint(equalToConstant: 48).isActive = true
        btnFavorited.heightAnchor.constraint(equalToConstant: 48).isActive = true
    }
    
    @objc
    func btnActionFavorite(_ sender: Any) {
        if let delegate = updateDelegate {
            delegate.updateFavorite()
        }
    }
    
    @objc
    func btnActionQuestionUp(_ sender: Any) {
        if let delgate = updateDelegate {
            delgate.updateUpvote(row: tag)
        }
    }
    
    @objc
    func btnActionQuestionDown(_ sender: Any) {
        if let delegate = updateDelegate {
            delegate.updateDownvote(row: tag)
        }
    }
}
