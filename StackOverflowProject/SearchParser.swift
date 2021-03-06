//
//  SearchParser.swift
//  StackOverflowProject
//
//  Created by dirtbag on 1/11/20.
//  Copyright © 2020 dirtbag. All rights reserved.
//

import Foundation

class SearchParser {
    
    func parse(data: Data, parsed: @escaping (SearchItems) -> Void) {
        
        //print(String(data: data, encoding: .utf8)!)
        
        // background the loading / parsing elements
        DispatchQueue.global(qos: .background).async {
            
            do {
                
                // create decoder
                let jsonDecoder = JSONDecoder()
                
                // decode json into structsspeciesData
                let searchItems = try jsonDecoder.decode(SearchItems.self, from: data)
                
                parsed(searchItems)
            } catch {
                print("Error Parsing JSON: \(error.localizedDescription)")
            }
        }
    }
}
