//
//  QuestionDetailVMAppTests.swift
//  StackOverflowProjectTests
//
//  Created by dirtbag on 2/4/20.
//  Copyright © 2020 dirtbag. All rights reserved.
//

import XCTest
@testable import StackOverflowProject

class QuestionDetailVMAppTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoadQuestion() {
        
        let testTitle = "Swift OAuth2 p2"
        let testQuesitonId = 41215025
        let expectation = self.expectation(description: "Testing Update Preview Function")

        let questionDetailVM = QuestionDetailViewModel()
        questionDetailVM.questionId = testQuesitonId
        questionDetailVM.loadQuestion {
           
            let title = questionDetailVM.question?.title
                
                XCTAssert(title! == testTitle, "Expected title: '\(testTitle)', but found: \(title!)")
            
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
