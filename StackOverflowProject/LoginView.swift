//
//  LoginView.swift
//  StackOverflowProject
//
//  Created by dirtbag on 1/30/20.
//  Copyright © 2020 dirtbag. All rights reserved.
//

import UIKit
import WebKit

class LoginView: UIView {
    
    var webView: WKWebView = {
        let webview = WKWebView()
        webview.translatesAutoresizingMaskIntoConstraints = false
        return webview
    }()

    var loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Login to Stack Overflow", for: .normal)
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
        addSubview(loginButton)
        addSubview(webView)
        
        // delegate
        webView.navigationDelegate = self
        
        // constraints
        loginButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        loginButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        webView.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 16).isActive = true
        webView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        webView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}

// MARK: Navigation Delegate
extension LoginView: WKNavigationDelegate {

    /// Delegate being used to catch URLs
    /// we are looking for the success URL from OAUTH
    /// that contains the access_token
    ///
    /// expected success URL format:  "https://stackexchange.com/oauth/login_success#access_token=1hyuOR0kn2zkboj(JPDCbg))&expires=86400"
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let urlString = navigationAction.request.url?.absoluteString {
            
            let leadElements = urlString.split(separator: "#")
            if leadElements.count < 2 {
                decisionHandler(.allow)
                return
            }
            
            let leadElement = leadElements[1]
            if leadElement.starts(with: "access_token") {
                let trailingElements = leadElement.split(separator: "&")
            let finalElements = trailingElements[0].split(separator: "=")

                let access_token = String(finalElements[1])
                
                //Session.shared.accessToken = access_token
               
            
                UserDefaults.standard.set(access_token, forKey: K.Key.accessToken)
                print("access_token=\(access_token)")
                
                self.window?.rootViewController = UINavigationController(rootViewController: SearchViewController())
            }
        }

        decisionHandler(.allow)
    }
}
