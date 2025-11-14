//
//  NetworkError.swift
//  BoynerNews
//
//  Created by Yaman Boztepe on 11.11.2025.
//

import Foundation

enum NetworkError: Error, Equatable {
    case serverError
    case invalidURL
    case decodingError
    case unknownError(String)
    
    var localizedDescription: String {
        switch self {
        case .serverError: 
            return "Server error."
        case .invalidURL: 
            return "Invalid URL."
        case .decodingError:
            return "Decoding failed"
        case .unknownError(let message):
            return message
        }
    }
}
