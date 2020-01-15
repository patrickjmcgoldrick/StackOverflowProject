//
//  NetworkController.swift
//  StackOverflowProject
//
//  Created by dirtbag on 1/11/20.
//  Copyright © 2020 dirtbag. All rights reserved.
//

import UIKit

class NetworkController {
    
    func getData(urlString: String, completed: @escaping (Data) -> Void) {
        
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else { return }
            print("Response URL: \(response?.url)")
            completed(data)
        }
        task.resume()
    }
    
    
    func postData(urlString: String, params: Data, completed: @escaping (Data) -> Void) {
        
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = params
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        
            guard let data = data else { return }
            print("Response URL: \(response?.url)")
            completed(data)
        }
        task.resume()
    }
}
