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
    
    var sut: NewsSourceListView.ViewModel!
    
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        sut = NewsSourceListView.ViewModel()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    // MARK: - Tests
    
    func test_getNewsSources() async {
        // Given
        fakeNetworkService.result = .success(NewsSourceListMockData.sourcesResponse)
        sut.service = fakeNetworkService
        
        // When
        await sut.getNewsSources()
        
        // Then
        XCTAssertEqual(sut.sources.count, 2)
        XCTAssertFalse(sut.categories.isEmpty)
    }
    
    func test_getNewsSources_whenNetworkErrorOccur_shouldPresentAlert() async {
        // Given
        fakeNetworkService.result = .failure(.serverError)
        sut.service = fakeNetworkService
        
        // When
        await sut.getNewsSources()
        
        // Then
        XCTAssertEqual(sut.alert?.title, NetworkError.serverError.localizedDescription)
    }
    
    func test_selectedCategories_whenEmpty_shouldShowAllSources() async {
        // Given
        fakeNetworkService.result = .success(NewsSourceListMockData.sourcesResponse)
        sut.service = fakeNetworkService
        
        // When
        await sut.getNewsSources()
        sut.selectedCategories = []
        
        // Then
        XCTAssertEqual(sut.sources.count, 2)
    }
    
    func test_selectedCategories_filterSources() async {
        // Given
        fakeNetworkService.result = .success(NewsSourceListMockData.sourcesResponse)
        sut.service = fakeNetworkService
        
        // When
        await sut.getNewsSources()
        sut.selectedCategories = ["sports"]
        
        // Then
        XCTAssertEqual(sut.sources.count, 1)
        XCTAssertEqual(sut.sources.first?.category, "sports")
    }
}
