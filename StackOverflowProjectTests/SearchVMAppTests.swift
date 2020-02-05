//
//  SearchVMAppTests.swift
//  StackOverflowProjectTests
//
//  Created by dirtbag on 2/4/20.
//  Copyright © 2020 dirtbag. All rights reserved.
//

import XCTest
@testable import StackOverflowProject

class SearchVMAppTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSearch() {
        
        let expectation = self.expectation(description: "Testing Detail Parser")

        let searchVM = SearchViewModel()
        searchVM.search("OAuth2 LinkedIn") {
            XCTAssert(searchVM.questions.count == 4, "Expected 4 rows, found: \(searchVM.questions.count) rows.")
            expectation.fulfill()
        }

        waitForExpectations(timeout: 15, handler: nil)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
