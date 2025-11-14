//
//  BoynerNewsUITests.swift
//  BoynerNewsUITests
//
//  Created by Yaman Boztepe on 11.11.2025.
//

import XCTest

final class BoynerNewsUITests: XCTestCase {
    private var app: XCUIApplication!
    private var sourceListScreen: NewsSourceListScreen!
    
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        sourceListScreen = NewsSourceListScreen(app: app)
        
        app.launchArguments = ["testing"]
        app.launch()
    }
    
    override func tearDown() {
        app.terminate()
    }
    
    // MARK: - Tests
    
    func test_sourceList_navigateToNewsList() {
        sourceListScreen
            .waitForListToLoad()
            .tapFirstSource()
            .waitForListToLoad()
            .verifySliderExists()
    }
    
    func test_newsList_pullToRefresh_simulatesErrorOnThirdAttempt() throws {
        let newsListScreen = sourceListScreen
            .waitForListToLoad()
            .tapFirstSource()
            .waitForListToLoad()
        
        newsListScreen
            .pullToRefresh()
            .waitForListToLoad()
            .pullToRefresh()
            .waitForListToLoad()
            .pullToRefresh()
            .verifyAlertExists(message: "Information could not be received!")
    }
}

