//
//  PageLoadTest.swift
//  DiagnalUITests
//
//  Created by Ruchi Agrawal on 4/8/24.
//

import XCTest
@testable import Diagnal
class PageLoadTest: XCTestCase {
  
    var totalpage: Int = 3
    var currentpage: Int = 1

    func testforCurrentPage() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        XCTAssertTrue(1...totalpage ~= currentpage)
       
    }

    
    func testPerformanceExample() throws {
            self.measure {
                let movieData = movies// Replace with sample data
                let data = fetchData(forPage: currentpage, completion: { result in
                    switch result {
                                            case .success(let data):
                        XCTAssertNotNil(data)
                    case .failure(let error):
                        XCTFail("Error fetching data: \(error)")
                    }
                })
                // Await completion for synchronous measurement (optional):
                // await data // Replace with appropriate completion handling
            }
        }

}
