//
//  AnswerParser.swift
//  StackOverflowProject
//
//  Created by dirtbag on 1/16/20.
//  Copyright © 2020 dirtbag. All rights reserved.
//

import Foundation

class AnswerParser {
    
    func parse(data: Data, parsed: @escaping (AnswerItems) -> Void) {
        
        // background the loading / parsing elements
        DispatchQueue.global(qos: .background).async {
            
            do {
                
                // create decoder
                let jsonDecoder = JSONDecoder()
                
                // decode json into structsspeciesData
                let answerItems = try jsonDecoder.decode(AnswerItems.self, from: data)
                
                parsed(answerItems)
            } catch {
                print("Error Parsing JSON: \(error.localizedDescription)")
            }
        }
    }
}
