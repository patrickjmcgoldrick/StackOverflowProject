//
//  StackOverflowProjectTests.swift
//  StackOverflowProjectTests
//
//  Created by dirtbag on 1/11/20.
//  Copyright © 2020 dirtbag. All rights reserved.
//

import XCTest
@testable import StackOverflowProject

class StackOverflowProjectTests: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testSearchParser() {
        
        let expectation = self.expectation(description: "Testing Search Parser")
        
        let testBundle = Bundle(for: type(of: self))
        let filename = "search"
        
        let path = testBundle.path(forResource: filename, ofType: "json")
        XCTAssertNotNil(path, "\(filename) file not found")
        
        guard let cleanPath = path else { return }
        
        // convert into URL
        let url = NSURL.fileURL(withPath: cleanPath)
        do {
            // load json into Data object
            let data = try Data(contentsOf: url)
            
            XCTAssertNotNil(data, "Data came back nil")
            
            let parser = SearchParser()
            parser.parse(data: data) { (searchData) in

                XCTAssertTrue(searchData.items.count == 8, "Expected 8 rows, but found \(searchData.items.count) rows.")
                
                expectation.fulfill()
            }
        } catch {
            assertionFailure("Error: " + error.localizedDescription)
        }
        // 15 second wait for timeout
        waitForExpectations(timeout: 15, handler: nil)
    }
}
