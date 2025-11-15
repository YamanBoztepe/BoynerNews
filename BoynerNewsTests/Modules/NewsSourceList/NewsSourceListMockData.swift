//
//  NewsSourceListMockData.swift
//  BoynerNews
//
//  Created by Yaman Boztepe on 11.11.2025.
//

@testable import BoynerNews

@MainActor
enum NewsSourceListMockData {
    static let screenDataResponse = NewsSourceList.SourcesResponse.parse(jsonFile: "top-headlines_sources")
    static let selectedCategory = "sports"
}
