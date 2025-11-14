//
//  NewsSourceListScreen.swift
//  BoynerNews
//
//  Created by Yaman Boztepe on 14.11.2025.
//

import XCTest

struct NewsSourceListScreen: ScreenProtocol {
    let app: XCUIApplication
    
    // MARK: - Elements
    
    var list: XCUIElement { app.collectionViews[Identifiers.NewsSourceList.list] }
    var categories: XCUIElement { app.scrollViews[Identifiers.NewsSourceList.categories] }
    var loadingIndicator: XCUIElement { app.otherElements[Identifiers.Common.loadingIndicator] }
    
    // MARK: - Actions
    
    @discardableResult
    func tapFirstSource() -> NewsListScreen {
        list.buttons.firstMatch.tap()
        return NewsListScreen(app: app)
    }
    
    // MARK: - Verifications
    
    @discardableResult
    func waitForListToLoad(timeout: TimeInterval = 5) -> Self {
        XCTAssertTrue(loadingIndicator.waitForNonExistence(timeout: timeout))
        XCTAssertTrue(list.exists)
        return self
    }
}
