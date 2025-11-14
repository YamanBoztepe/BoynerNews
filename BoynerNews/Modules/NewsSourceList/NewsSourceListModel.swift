//
//  NewsSourceListModel.swift
//  BoynerNews
//
//  Created by Yaman Boztepe on 11.11.2025.
//

import Foundation

enum NewsSourceList {
    // MARK: - Static Texts
    static let title = "News Sources"
    static let emptyListMessage = "No Sources Found.\nTry Again Later"
    
    // MARK: - Response Models
    struct SourcesResponse: Decodable {
        let sources: [Source]?
    }
    
    struct Source: Decodable, Identifiable {
        let id: String?
        let name: String?
        let description: String?
        let url: String?
        let category: String?
        let language: String?
        let country: String?
    }
}
