//
//  LoginViewController.swift
//  StackOverflowProject
//
//  Created by dirtbag on 1/15/20.
//  Copyright © 2020 dirtbag. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
             
    let loginView = LoginView()
    let viewModel = LoginViewModel()
    
    // MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginView.viewModel = viewModel
        loginView.loginButton.addTarget(self, action: #selector(btnActionLogin), for: .touchUpInside)
        view = loginView
    }
    
    @objc
    func btnActionLogin() {
        
        let urlBulder = URLBuilder()
        
        let urlString = urlBulder.getLoginPageURL()
        
        guard let url = URL(string: urlString) else { return }

        let request = URLRequest(url: url)
        loginView.webView.load(request)
    }
}
