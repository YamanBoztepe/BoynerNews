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
    }
    
    override func tearDown() {
        app.terminate()
    }
    
    private func launch(with scenario: String? = nil) {
        var launchArguments = [UITestMockData.uiTestArgument]
        
        if let scenario {
            launchArguments.append(scenario)
        }
        
        app.launchArguments = launchArguments
        app.launch()
    }
    
    // MARK: - Tests
    
    func test_sourceList_showsErrorAlert_onLaunchFailure() {
        // Given
        launch(with: UITestMockData.serverErrorFailure)
        
        // Then
        sourceListScreen.verifyAlertExists(message: UITestMockData.serverErrorMessage)
    }
    
    func test_sourceList_navigateToNewsList() {
        // Given
        launch()
        
        // When
        let newsListScreen = sourceListScreen
            .waitForListToLoad()
            .tapFirstSource()
        
        // Then
        newsListScreen
            .waitForListToLoad()
            .verifySliderExists()
    }
    
    func test_newsList_pullToRefresh_simulatesErrorOnThirdAttempt() throws {
        // Given
        launch()
        
        // When
        let newsListScreen = sourceListScreen
            .waitForListToLoad()
            .tapFirstSource()
            .waitForListToLoad()
        
        // then
        newsListScreen
            .pullToRefresh()
            .waitForListToLoad()
            .pullToRefresh()
            .waitForListToLoad()
            .pullToRefresh()
            .verifyAlertExists(message: UITestMockData.informationErrorMessage)
    }
}

