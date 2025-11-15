//
//  NetworkConstants.swift
//  BoynerNews
//
//  Created by Yaman Boztepe on 11.11.2025.
//

enum NetworkConstants {
    static let apiKey = "ee39302f2a97490abbd69d073c279505"
    
    enum BaseURL: String {
        case release = "https://newsapi.org/v2/"
        case dummyData = ""
    }
    
    enum Endpoints: String {
        case topHeadlines = "top-headlines"
        case sources = "top-headlines/sources"
    }
}
