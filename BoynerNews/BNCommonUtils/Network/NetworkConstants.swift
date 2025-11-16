//
//  NetworkConstants.swift
//  BoynerNews
//
//  Created by Yaman Boztepe on 11.11.2025.
//

enum NetworkConstants {
    static let apiKey = ConfigValueReader.string(forKey: "API_KEY")
    
    enum BaseURL: String {
        case release = "https://newsapi.org/v2/"
        case dummyData = ""
    }
    
    enum Endpoints: String {
        case topHeadlines = "top-headlines"
        case sources = "top-headlines/sources"
    }
}
