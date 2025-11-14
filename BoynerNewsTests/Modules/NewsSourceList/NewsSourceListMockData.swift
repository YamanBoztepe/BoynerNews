//
//  NewsSourceListMockData.swift
//  BoynerNews
//
//  Created by Yaman Boztepe on 11.11.2025.
//

@testable import BoynerNews

enum NewsSourceListMockData {
    
    static let mixedSources: [NewsSourceList.Source] = [
        .init(id: "le-monde",
              name: "Le Monde",
              description: "Actualités françaises.",
              url: "https://lemonde.fr",
              category: "general",
              language: "fr",
              country: "fr"),
        .init(id: "abc-news",
              name: "ABC News",
              description: "Breaking news and analysis.",
              url: "https://abcnews.go.com",
              category: "general",
              language: "en",
              country: "us"),
        .init(id: "espn",
              name: "ESPN",
              description: "Sports news and updates.",
              url: "https://espn.com",
              category: "sports",
              language: "en",
              country: "us")
    ]
    
    static let sourcesResponse = NewsSourceList.SourcesResponse(sources: mixedSources)
}
