//
//  SearchParser.swift
//  StackOverflowProject
//
//  Created by dirtbag on 1/11/20.
//  Copyright © 2020 dirtbag. All rights reserved.
//

import Foundation

class SearchParser {
    
    func parse(data: Data, parsed: @escaping (SearchData) -> Void) {
        
        // background the loading / parsing elements
        DispatchQueue.global(qos: .background).async {
            
            do {
                
                // create decoder
                let jsonDecoder = JSONDecoder()
                
                // decode json into structsspeciesData
                let searchData = try jsonDecoder.decode(SearchData.self, from: data)
                
                parsed(searchData)
                
            } catch {
                print("Error Parsing JSON: \(error.localizedDescription)")
            }
        }
    }
}
