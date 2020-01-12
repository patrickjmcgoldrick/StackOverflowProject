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

    @IBOutlet weak var webKit: WKWebView!
    
    var questionURL: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let urlString = questionURL else { return }
        guard let url = URL(string: urlString) else { return }

        let request = URLRequest(url: url)
        webKit.load(request)
        webKit.allowsBackForwardNavigationGestures = true
        webKit.allowsLinkPreview = true
    }
}
