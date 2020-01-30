//
//  SearchViewModel.swift
//  StackOverflowProject
//
//  Created by dirtbag on 1/29/20.
//  Copyright © 2020 dirtbag. All rights reserved.
//

import Foundation

class SearchViewModel {

    let urlBuilder = URLBuilder()
    var questions = [SearchData]()
    
    func search(_ searchText: String, searchCompleted: @escaping () -> Void) {
        
       let url = urlBuilder.getSearchURL(searchTerm: searchText)
        let network = NetworkManager.shared
        network.getData(urlString: url) { (data) in
                        
            print(String(data: data, encoding: .utf8)!)
            
            let parser = SearchParser()
            parser.parse(data: data) { (searchData) in
                
                self.questions = searchData.items
                
                print("Quota: \(searchData.quota_remaining)")
                print(self.questions.count)
                
                searchCompleted()
            }
        }
    }
}
