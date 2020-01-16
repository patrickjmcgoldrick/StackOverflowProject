//
//  NetworkController.swift
//  StackOverflowProject
//
//  Created by dirtbag on 1/11/20.
//  Copyright © 2020 dirtbag. All rights reserved.
//

import UIKit

class NetworkManager {
    
    private enum API {
        static let baseURL = URL(string: "https://api.stackexchange.com/")
    }
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func getData(urlString: String, completed: @escaping (Data) -> Void) {
        
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else { return }
            print("Response URL: \(response?.url)")
            completed(data)
        }
        task.resume()
    }
    
    static func getRecentQuestions(fromDate: Int, toDate: Int, completion: @escaping (Data?, Error?) -> Void) {
        
        let pathParams = ["2.2/", "questions"]
        let queryParams = ["fromdate": "\(fromDate)",
                           "todate": "\(toDate)",
                           "order": "desc",
                           "sort": "activity",
                           "site": "stackoverflow",
                           "filter": "!9X(-vwYGT"]
        
        
        NetworkManager.makeRequest(url: API.baseURL!, appendingPath: pathParams, queries: queryParams) { (data, errors) in
            // do nothing for now
        }
    }
    
    static func makeRequest(method: String = "GET", url: URL, appendingPath: [String], queries: [String:String] = [:], completion: @escaping (Data?, Error?) -> Void) {
        
        var url = url
        for path in appendingPath {
            url.appendPathComponent(path)
        }
        
        var queryArray = [URLQueryItem]()
        for query in queries {
            queryArray.append(URLQueryItem(name: query.key, value: query.value))
        }
        
        var urlComponents = URLComponents()
        urlComponents.scheme = url.scheme
        urlComponents.host = url.host
        urlComponents.path = url.path
        if queryArray.count > 0 {
            urlComponents.queryItems = queryArray
        }
       
        guard let finalURL = urlComponents.url else {
            NSLog("Constructing the URL has failed.")
            return
        }
        print("finalURL: ", finalURL)
        
        var request = URLRequest(url: finalURL)
        request.httpMethod = method
        /*
        dataTask(request: request) { (data, error) in
            completion(data, error)
        }
 */
    }
    
    /*
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
 */
}
