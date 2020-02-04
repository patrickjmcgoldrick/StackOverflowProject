//
//  PostCellView.swift
//  StackOverflowProject
//
//  Created by dirtbag on 1/30/20.
//  Copyright © 2020 dirtbag. All rights reserved.
//

import UIKit

// Base Cell for displaying Question and Answer table cells,  With most
// of their display objects overlapping a Parent class was
// necessary for code reuse.
class PostTableViewCell: UITableViewCell {
    
    var updateDelegate: UpdateDelegate?
    
    var lblBody: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    var lblScore: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var btnUpVote: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(imageLiteralResourceName: "up_grey"), for: .normal)
        button.setImage(UIImage(imageLiteralResourceName: "up"), for: .highlighted)
        return button
    }()
    
    var btnDownVote: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(imageLiteralResourceName: "down_grey"), for: .normal)
        button.setImage(UIImage(imageLiteralResourceName: "down"), for: .highlighted)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
     
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        assertionFailure("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        // Initialization code
        addSubview(lblBody)
        addSubview(btnUpVote)
        addSubview(lblScore)
        addSubview(btnDownVote)
        
        lblBody.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor).isActive = true
        lblBody.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor).isActive = true
        lblBody.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor).isActive = true
        lblBody.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor).isActive = true
        
        btnUpVote.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor).isActive = true
        btnUpVote.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor).isActive = true
        btnUpVote.widthAnchor.constraint(equalToConstant: 48).isActive = true
        btnUpVote.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        lblScore.topAnchor.constraint(equalTo: btnUpVote.bottomAnchor).isActive = true
        lblScore.centerXAnchor.constraint(equalTo: btnUpVote.centerXAnchor).isActive = true
        
        btnDownVote.topAnchor.constraint(equalTo: lblScore.bottomAnchor).isActive = true
        btnDownVote.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor).isActive = true
        btnDownVote.widthAnchor.constraint(equalToConstant: 48).isActive = true
        btnDownVote.heightAnchor.constraint(equalToConstant: 48).isActive = true
    }
}
