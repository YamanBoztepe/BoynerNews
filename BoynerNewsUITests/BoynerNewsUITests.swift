//
//  BoynerNewsUITests.swift
//  BoynerNewsUITests
//
//  Created by Yaman Boztepe on 11.11.2025.
//

import XCTest

final class BoynerNewsUITests: XCTestCase {
    private var app: XCUIApplication!
    private var newsSourceListScreen: NewsSourceListScreen!
    private var newsListScreen: NewsListScreen!
    
    override func setUp() {
        continueAfterFailure = false
        
    }
    
    override func tearDown() {
        app.terminate()
    }
    
    func testExample() {
        app = XCUIApplication()
        app.launchArguments = ["testing"]
        app.launch()              
    }
    
    // MARK: - Tests
    
    func test_newsSourceList_whenSuccess_loadsAndNavigatesToArticles() {
        // When
        let listViewLoaded = newsSourceListScreen.waitForListView()
        newsSourceListScreen.tapSource(id: "bbc-news")
        
        // Then
        XCTAssertTrue(listViewLoaded)
        XCTAssertTrue(newsListScreen.waitForSlider())
        XCTAssertTrue(newsListScreen.recommendationSection.exists)
    }
}
