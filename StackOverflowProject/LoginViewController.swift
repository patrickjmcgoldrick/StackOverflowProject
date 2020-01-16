//
//  LoginViewController.swift
//  StackOverflowProject
//
//  Created by dirtbag on 1/15/20.
//  Copyright © 2020 dirtbag. All rights reserved.
//

import UIKit
import WebKit

class LoginViewController: UIViewController {
            
    @IBOutlet weak var webView: WKWebView!
    
    var accessToken: String?
    
    // MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.navigationDelegate = self
    }
    
    @IBAction private func btnActionLogin(_ sender: Any) {
        
        let urlBulder = URLBuilder()
        
        let urlString = urlBulder.getLoginPageURL()
        
        guard let url = URL(string: urlString) else { return }

        let request = URLRequest(url: url)
        webView.load(request)
    }
}

// MARK: Navigation Delegate
extension LoginViewController: WKNavigationDelegate {

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
                
                Session.shared.accessToken = access_token
                print("access_token=\(access_token)")
                performSegue(withIdentifier: "loginToSearch", sender: self)
            }
        }

        decisionHandler(.allow)
    }
}
