//
//  NewsListMockData.swift
//  BoynerNews
//
//  Created by Yaman Boztepe on 13.11.2025.
//

@testable import BoynerNews

enum NewsListMockData {
    static let articles: [NewsList.Article] = [
        .init(
            source: .init(id: "techcrunch", name: "TechCrunch"),
            author: "Jane Doe",
            title: "Apple unveils new features in iOS",
            description: "A quick look at the latest iOS features announced today.",
            url: "https://example.com/apple-ios-news",
            urlToImage: "https://example.com/images/ios.jpg",
            publishedAt: "2025-11-13T09:15:00Z",
            content: "Apple introduced several updates focusing on performance and privacy..."
        ),
        .init(
            source: .init(id: nil, name: "Boyner Newsroom"),
            author: "Boyner Team",
            title: "Boyner announces holiday campaign",
            description: "Exclusive offers and curated collections for the holiday season.",
            url: "https://news.boyner.com/holiday-campaign",
            urlToImage: "https://news.boyner.com/assets/holiday.jpg",
            publishedAt: "2025-11-10T12:00:00Z",
            content: "The campaign features limited-time deals and special events across stores..."
        ),
        .init(
            source: .init(id: "verge", name: "The Verge"),
            author: "John Smith",
            title: "Wearables market sees record growth",
            description: "Q3 reports show significant gains in wearable device shipments.",
            url: "https://example.com/wearables-growth",
            urlToImage: "https://example.com/images/wearables.jpg",
            publishedAt: "2025-11-05T08:30:00Z",
            content: "Analysts attribute the growth to new health features and broader adoption..."
        )
        ,
        .init(
            source: .init(id: "wired", name: "WIRED"),
            author: "Alice Johnson",
            title: "AI transforms retail customer experience",
            description: "Retailers adopt on-device AI to deliver personalized shopping.",
            url: "https://example.com/ai-retail",
            urlToImage: "https://example.com/images/ai-retail.jpg",
            publishedAt: "2025-11-02T14:45:00Z",
            content: "On-device models enable privacy-preserving recommendations and faster interactions..."
        ),
        .init(
            source: .init(id: nil, name: "Anadolu Ajansi"),
            author: "AA",
            title: "Türkiye'de e-ticaret hacmi yeni rekor kırdı",
            description: "Yılın üçüncü çeyreğinde e-ticaret hacminde çift haneli büyüme görüldü.",
            url: "https://example.com/e-ticaret-rekor",
            urlToImage: "https://example.com/images/ecommerce-tr.jpg",
            publishedAt: "2025-10-28T07:20:00Z",
            content: "Uzmanlar büyümenin kampanyalar ve hızlı teslimat seçenekleriyle desteklendiğini belirtiyor..."
        )
    ]

    static let articlesResponse = NewsList.ArticlesResponse(articles: articles)

    
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
