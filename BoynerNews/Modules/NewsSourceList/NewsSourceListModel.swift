//
//  NewsSourceListModel.swift
//  BoynerNews
//
//  Created by Yaman Boztepe on 11.11.2025.
//

import SwiftUI

enum NewsSourceList {
    // MARK: - Constant
    static let title = "News Sources"
    static let emptyListMessage = "No Sources Found.\nTry Again Later"
    static let categorySectionInsets = EdgeInsets(top: 8, leading: 0, bottom: 16, trailing: 0)
    static let englishFilter = "en"
    
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
