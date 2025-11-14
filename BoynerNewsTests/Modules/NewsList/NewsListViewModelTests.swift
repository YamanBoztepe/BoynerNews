//
//  NewsListViewModelTests.swift
//  BoynerNews
//
//  Created by Yaman Boztepe on 13.11.2025.
//

import XCTest
@testable import BoynerNews

@MainActor
final class NewsListViewModelTests: CommonXCTestCase {
    // MARK: Subject under test
    
    var sut: NewsListView.ViewModel!
    
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        sut = NewsListView.ViewModel()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    // MARK: - Tests
    
    func test_getNews() async {
        // Given
        fakeNetworkService.result = .success(NewsListMockData.articlesResponse)
        sut.service = fakeNetworkService
        
        // When
        await sut.getNews(for: "bbc")
        sut.articles.first!.onToggleReadingList("")
        
        // Then
        XCTAssertEqual(sut.articles.count, NewsListMockData.articles.count)
        XCTAssertEqual(sut.sliderArticles.count, NewsListMockData.articles.prefix(3).count)
        XCTAssertEqual(sut.listArticles.count, NewsListMockData.articles.dropFirst(3).count)
        XCTAssertEqual(sut.screenTitle, NewsListMockData.articles.first?.source.name)
        XCTAssertFalse(sut.noArticlesFound)
    }
    
    func test_onToggleReadingList_whenArticleNotExists() async {
        // Given
        fakeNetworkService.result = .success(NewsListMockData.articlesResponse)
        sut.service = fakeNetworkService
        
        fakeArticleRepository.isArticleExists = false
        sut.articlesRepository = fakeArticleRepository
        
        // When
        await sut.getNews(for: "bbc")
        let article = sut.articles.first!
        article.onToggleReadingList(article.id)
        
        // Then
        XCTAssertTrue(fakeArticleRepository.isArticleExistsCalled)
        XCTAssertTrue(fakeArticleRepository.addArticleCalled)
        XCTAssertTrue(sut.articles.first!.isAddedToReadingList)
        XCTAssertFalse(fakeArticleRepository.removeArticleCalled)
    }
    
    func test_onToggleReadingList_whenArticleExists() async {
        // Given
        fakeNetworkService.result = .success(NewsListMockData.articlesResponse)
        sut.service = fakeNetworkService
        
        fakeArticleRepository.isArticleExists = true
        sut.articlesRepository = fakeArticleRepository
        
        // When
        await sut.getNews(for: "bbc")
        let article = sut.articles.first!
        article.onToggleReadingList(article.id)
        
        // Then
        XCTAssertTrue(fakeArticleRepository.isArticleExistsCalled)
        XCTAssertTrue(fakeArticleRepository.removeArticleCalled)
        XCTAssertFalse(sut.articles.first!.isAddedToReadingList)
        XCTAssertFalse(fakeArticleRepository.addArticleCalled)
    }
    
    func test_pullToRefresh() async {
        // Given
        sut.articles = NewsListMockData.rowViewModels
        fakeNetworkService.result = .success(NewsListMockData.articlesResponse)
        sut.service = fakeNetworkService
        sut.screenRequest = BNServiceRequest(endpoint: .topHeadlines)
        
        // When
        await sut.pullToRefresh()
        
        // Then
        XCTAssertNotEqual(sut.articles.first?.id, NewsListMockData.rowViewModels.first?.id)
        XCTAssertFalse(sut.noArticlesFound)
    }
    
    func test_pullToRefresh_shouldSimulateNetworkError() async {
        // Given
        sut.articles = NewsListMockData.rowViewModels
        
        // When
        for _ in 0...3 {
            await sut.pullToRefresh()
        }
        
        // Then
        XCTAssertTrue(sut.articles.isEmpty)
        XCTAssertTrue(sut.noArticlesFound)
        XCTAssertNotNil(sut.alert)
        
    }
    
    func test_startPolling() {
        // Given
        sut.pollingService = fakePollingService
        
        // When
        sut.startPolling()
        
        // Then
        XCTAssertTrue(fakePollingService.startPollingCalled)
    }
    
    func test_stopPolling() {
        // Given
        sut.pollingService = fakePollingService
        
        // When
        sut.stopPolling()
        
        // Then
        XCTAssertTrue(fakePollingService.stopPollingCalled)
    }
}
