//
//  NewPostVMAppTests.swift
//  StackOverflowProjectTests
//
//  Created by dirtbag on 2/4/20.
//  Copyright © 2020 dirtbag. All rights reserved.
//

import XCTest
@testable import StackOverflowProject

class NewPostVMAppTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testUpdatePreview() {
        let title = "this is a test of emergency broadcast system"
        let body = "They are coming take me away hahw, they are coming to take me away, hoho, hehe, haha.  Those nice young men in their clean white coats and their coming to take me away."
        let tags = "testing swift"
        let expectation = self.expectation(description: "Testing Update Preview Function")

        let newPostVM = NewPostViewModel()
        newPostVM.updatePreview(title: title, body: body, tags: tags) {
            print("completed")
            XCTAssert(newPostVM.previewQuestion?.title == "this is a test of emergency broadcast system", "Found unexpected title: \(String(describing: newPostVM.previewQuestion?.title))")
                
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
