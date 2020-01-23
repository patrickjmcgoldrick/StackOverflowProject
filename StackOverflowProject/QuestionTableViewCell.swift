//
//  QuestionTableViewCell.swift
//  StackOverflowProject
//
//  Created by dirtbag on 1/15/20.
//  Copyright © 2020 dirtbag. All rights reserved.
//

import UIKit
import WebKit

class QuestionTableViewCell: UITableViewCell {

    @IBOutlet weak var lblBody: UILabel!
    
    @IBOutlet weak var btnFavorited: UIButton!
    
    @IBOutlet weak var lblScore: UILabel!
    
    var updateDelegate: UpdateDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        print("selected")
    }
    
    @IBAction func btnActionFavorite(_ sender: Any) {
        if let delegate = updateDelegate {
            delegate.updateFavorite()
        }
    }
}
