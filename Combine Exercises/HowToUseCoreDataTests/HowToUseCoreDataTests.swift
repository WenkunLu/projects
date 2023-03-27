//
//  HowToUseCoreDataTests.swift
//  HowToUseCoreDataTests
//
//  Created by Master Lu on 2023/2/20.
//

import XCTest

@testable import HowToUseCoreData
final class HowToUseCoreDataTests: XCTestCase {

    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        
    }

    func testCreate() {
        let bookManager = BookManager()
        let newBook = Book(bookTitle: "欧洲", author: "Jack", publicDate: .now, category: .math)
        print(bookManager.shelfs.count)
        bookManager.addBook(book: newBook)
        
        var newBook2 = newBook
        newBook2.category = .history
        bookManager.editBook(newBook: newBook2)
        print(bookManager.shelfs.count)

    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
