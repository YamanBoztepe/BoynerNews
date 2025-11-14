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
    
    // MARK: - Helpers
    
    private func readingListButton(id: String) -> XCUIElement {
        return app.buttons["toggle_reading_list_button_\(id)"]
    }
    
    // MARK: - Actions
    
    @discardableResult
    func pullToRefresh() -> Self {
        let firstCell = list.cells.firstMatch
        let start = firstCell.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 0))
        let end = start.withOffset(CGVector(dx: 0, dy: 500))
        start.press(forDuration: 0.1, thenDragTo: end)
        
        return self
    }
    
    @discardableResult
    func toggleReadingList(forArticleId id: String) -> Self {
        readingListButton(id: id).tap()
        return self
    }
    
    // MARK: - Verifications
    
    @discardableResult
    func waitForListToLoad(timeout: TimeInterval = 5) -> Self {
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
    func verifyAlertExists(message: String, timeout: TimeInterval = 5) -> Self {
        let alert = app.staticTexts[message]
        XCTAssertTrue(alert.waitForExistence(timeout: timeout))
        return self
    }
}
