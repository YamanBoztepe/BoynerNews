//
//  NewsList.swift
//  BoynerNews
//
//  Created by Yaman Boztepe on 11.11.2025.
//

import Foundation

enum NewsList {
    // MARK: - Static Texts
    static let title = "News"
    static let errorAlertMessage = "Information could not be received!"
    static let emptyListMessage = "No Articles Found.\nTry Again Later"
    static let tryAgainText = "Try Again"
    static let breakingNewsSectionTitle = "Breaking News"
    static let recommendationsSectionTitle = "Recommendations"
    static let breakingNewsSectionHeight: CGFloat = 225
    
    // MARK: - Response Models
    struct ArticlesResponse: Decodable {
        let articles: [Article]?
    }
    
    struct Article: Decodable, Identifiable {
        let source: ArticleSource
        let author: String?
        let title: String?
        let description: String?
        let url: String?
        let urlToImage: String?
        let publishedAt: String?
        let content: String?
        
        /// Converts ISO Formatted `publishedAt` to Date or returns `distantPast` if nil
        var dateValue: Date {
            publishedAt?.isoStringToDate ?? .distantPast
        }
        
        /// Generates unique id based on `url` since backend does not provide one
        var id: String { url.stringValue }
    }
    
    struct ArticleSource: Decodable {
        let id: String?
        let name: String?
    }
}
