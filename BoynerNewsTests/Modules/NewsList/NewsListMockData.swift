//
//  NewsListMockData.swift
//  BoynerNews
//
//  Created by Yaman Boztepe on 13.11.2025.
//

@testable import BoynerNews

@MainActor
enum NewsListMockData {
    static let screenDataResponse = NewsList.ArticlesResponse.parse(jsonFile: "top-headlines")
    static let sourceName = "bbc-news"
    
    static let rowViewModels: [NewsRowViewModel] = [
        NewsRowViewModel(id: "1",
                         title: "Apple unveils new features in iOS",
                         date: "13 Nov, 12:15",
                         imageURL: "https://example.com/images/ios.jpg",
                         isAddedToReadingList: false,
                         onToggleReadingList: { _ in }),
        NewsRowViewModel(id: "2",
                         title: "Boyner announces holiday campaign",
                         date: "10 Nov, 15:00",
                         imageURL: "https://news.boyner.com/assets/holiday.jpg",
                         isAddedToReadingList: true,
                         onToggleReadingList: { _ in }),
        NewsRowViewModel(id: "3",
                         title: "Wearables market sees record growth",
                         date: "05 Nov, 11:30",
                         imageURL: "https://example.com/images/wearables.jpg",
                         isAddedToReadingList: false,
                         onToggleReadingList: { _ in }),
        NewsRowViewModel(id: "4",
                         title: "AI transforms retail customer experience",
                         date: "02 Nov, 17:45",
                         imageURL: "https://example.com/images/ai-retail.jpg",
                         isAddedToReadingList: false,
                         onToggleReadingList: { _ in }),
        NewsRowViewModel(id: "5",
                         title: "Türkiye'de e-ticaret hacmi yeni rekor kırdı",
                         date: "28 Oct, 10:20",
                         imageURL: "https://example.com/images/ecommerce-tr.jpg",
                         isAddedToReadingList: true,
                         onToggleReadingList: { _ in })
    ]
}
