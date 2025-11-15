//
//  NewsSourceListViewModelTests.swift
//  BoynerNews
//
//  Created by Yaman Boztepe on 11.11.2025.
//

import XCTest
@testable import BoynerNews

@MainActor
final class NewsSourceListViewModelTests: CommonXCTestCase {
    // MARK: Subject under test
    
    var sut: NewsSourceListViewModel!
    
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        sut = NewsSourceListViewModel()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    // MARK: - Tests
    
    func test_getNewsSources() async {
        // When
        await sut.getNewsSources()
        
        // Then
        let sources = NewsSourceListMockData.screenDataResponse?.sources
        
        XCTAssertEqual(sut.sources.count, sources?.count)
        XCTAssertFalse(sut.categories.isEmpty)
    }
    
    func test_selectedCategories_whenEmpty_shouldShowAllSources() async {
        // When
        await sut.getNewsSources()
        sut.selectedCategories = []
        
        // Then
        let sources = NewsSourceListMockData.screenDataResponse?.sources
        
        XCTAssertEqual(sut.sources.count, sources?.count)
    }
    
    func test_selectedCategories_filterSources() async {
        // When
        await sut.getNewsSources()
        sut.selectedCategories = [NewsSourceListMockData.selectedCategory]
        
        // Then
        XCTAssertEqual(sut.sources.count, 7)
        XCTAssertEqual(sut.sources.first?.category, NewsSourceListMockData.selectedCategory)
    }
}
