//
//  NewsListViewModel.swift
//  BoynerNews
//
//  Created by Yaman Boztepe on 11.11.2025.
//

import Combine
import SwiftUI

final class NewsListViewModel: BaseViewModel {
    @Published var sliderArticles = [NewsRowViewModel]()
    @Published var listArticles = [NewsRowViewModel]()
    @Published var noArticlesFound = false
    @Published var screenTitle = ""
    
    private var pullToRefreshCounter = 0
    private var timer: Timer?
    
    var screenRequest: BNServiceRequest?
    var articles = [NewsRowViewModel]() {
        didSet {
            sliderArticles = Array(articles.prefix(3))
            listArticles = Array(articles.dropFirst(3))
        }
    }
    
    func getNews(for source: String) async {
        let request = BNServiceRequest(endpoint: .topHeadlines, parameters: ["sources": source])
        let response = await callService(request, responseType: NewsList.ArticlesResponse.self)
        
        articles = getArticles(from: response)
        screenTitle = response?.articles?.first?.source.name ?? NewsList.title
        screenRequest = request
        noArticlesFound = articles.isEmpty
    }
    
    func pullToRefresh() async {
        await refreshNews()
        simulateNetworkError()
    }
    
    func startPolling() {
        pollingService.startPolling(interval: 60) { [weak self] in
            Task {
                await self?.refreshNews()
            }
        }
    }
    
    func stopPolling() {
        pollingService.stopPolling()
    }
}

// MARK: - Helper Methods

private extension NewsListViewModel {
    
    func refreshNews() async {
        guard let screenRequest else {
            return
        }
        
        let response = await callService(screenRequest, responseType: NewsList.ArticlesResponse.self)
        let newArticles = getArticles(from: response)
        
        // Check if new article is published
        if articles.first?.id != newArticles.first?.id {
            articles = newArticles
        }
        
        noArticlesFound = articles.isEmpty
    }
    
    func getArticles(from response: NewsList.ArticlesResponse?) -> [NewsRowViewModel] {
        // Sort articles by their dates
        let sortedArticles = (response?.articles).valueOrEmpty.sorted { $0.dateValue > $1.dateValue }
        
        // Mapping for UI-ready model
        return sortedArticles.map { article in
            let isAddedToReadingList = articlesRepository.isArticleExists(article.id)
            
            return NewsRowViewModel(id: article.id,
                                    title: article.title.stringValue,
                                    date: article.dateValue.toString(),
                                    imageURL: article.urlToImage.stringValue,
                                    isAddedToReadingList: isAddedToReadingList) { [weak self] articleId in
                self?.onToggleReadingList(forArticleWithId: articleId)
            }
        }
    }
    
    func onToggleReadingList(forArticleWithId id: String) {
        let isArticleExists = articlesRepository.isArticleExists(id)
        
        if isArticleExists {
            articlesRepository.removeArticle(id)
        } else {
            articlesRepository.addArticle(id)
        }
        
        if let index = articles.firstIndex(where: { $0.id == id }) {
            articles[index].isAddedToReadingList = !isArticleExists
        }
    }
    
    func simulateNetworkError() {
        pullToRefreshCounter += 1
        
        if pullToRefreshCounter.isMultiple(of: 3) {
            articles.removeAll()
            noArticlesFound = articles.isEmpty
            
            let retryButton = AlertButton(title: NewsList.tryAgainText) { [weak self] in
                Task {
                    await self?.refreshNews()
                }
            }
            alert = AlertModel(title: NewsList.errorAlertMessage, buttons: [retryButton])
        }
    }
}
