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
    
    var sut: NewsListViewModel!
    
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        sut = NewsListViewModel()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    // MARK: - Tests
    
    func test_getNews() async {
        // When
        await sut.getNews(for: NewsListMockData.sourceName)
        
        // Then
        let articles = NewsListMockData.screenDataResponse?.articles
        
        XCTAssertEqual(sut.articles.count, articles?.count)
        XCTAssertEqual(sut.sliderArticles.count, articles?.prefix(3).count)
        XCTAssertEqual(sut.listArticles.count, articles?.dropFirst(3).count)
        XCTAssertEqual(sut.screenTitle, articles?.first?.source.name)
        XCTAssertFalse(sut.noArticlesFound)
    }
    
    func test_onToggleReadingList_whenArticleNotExists() async {
        // Given
        fakeArticleRepository.isArticleExists = false
        sut.articlesRepository = fakeArticleRepository
        
        // When
        await sut.getNews(for: NewsListMockData.sourceName)
        
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
        fakeArticleRepository.isArticleExists = true
        sut.articlesRepository = fakeArticleRepository
        
        // When
        await sut.getNews(for: NewsListMockData.sourceName)
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
