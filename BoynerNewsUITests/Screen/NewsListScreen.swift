//
//  NewsListScreen.swift
//  BoynerNews
//
//  Created by Yaman Boztepe on 14.11.2025.
//

import XCTest

struct NewsListScreen: ScreenProtocol {
    let app: XCUIApplication
    
    // MARK: - Elements
    
    var list: XCUIElement { app.collectionViews[Identifiers.NewsList.list] }
    var slider: XCUIElement { app.collectionViews[Identifiers.NewsList.slider] }
    var loadingIndicator: XCUIElement { app.otherElements[Identifiers.Common.loadingIndicator] }
    
    // MARK: - Actions
    
    @discardableResult
    func pullToRefresh() -> Self {
        let listHeight = list.frame.height
        let dragDistance = listHeight * 0.7
        let start = list.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.2))
        let end = start.withOffset(CGVector(dx: 0, dy: dragDistance))
        start.press(forDuration: 0, thenDragTo: end)
        
        return self
    }
    
    // MARK: - Verifications
    
    @discardableResult
    func waitForListToLoad(timeout: TimeInterval = 1) -> Self {
        XCTAssertTrue(loadingIndicator.waitForNonExistence(timeout: timeout))
        XCTAssertTrue(list.exists)
        return self
    }
    
    @discardableResult
    func verifySliderExists() -> Self {
        XCTAssertTrue(slider.exists)
        return self
    }
    
    @discardableResult
    func verifyAlertExists(message: String, timeout: TimeInterval = 1) -> Self {
        let alert = app.staticTexts[message]
        XCTAssertTrue(alert.waitForExistence(timeout: timeout))
        return self
    }
}
