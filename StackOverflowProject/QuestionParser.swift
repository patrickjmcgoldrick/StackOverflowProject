//
//  QuestionParser.swift
//  StackOverflowProject
//
//  Created by dirtbag on 1/23/20.
//  Copyright © 2020 dirtbag. All rights reserved.
//

import Foundation

class QuestionParser {
    
    func parse(data: Data, parsed: @escaping (QuestionItems) -> Void) {
        
        //print(String(data: data, encoding: .utf8)!)
        
        // background the loading / parsing elements
        DispatchQueue.global(qos: .background).async {
            
            do {
                
                // create decoder
                let jsonDecoder = JSONDecoder()
                
                // decode json into structsspeciesData
                let questionItems = try jsonDecoder.decode(QuestionItems.self, from: data)
                
                parsed(questionItems)
            } catch {
                print("Error Parsing JSON: \(error.localizedDescription)")
                print(String(data: data, encoding: .utf8)!)
            }
        }
    }
}
