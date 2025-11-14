//
//  NetworkManagerMockData.swift
//  BoynerNews
//
//  Created by Yaman Boztepe on 11.11.2025.
//

import Foundation

enum NetworkManagerMockData {
    static let data: Data = """
        {
          "status": "ok",
          "articles": [
            {
              "source": { "id": "test", "name": "Test Source" },
              "author": "Yaman",
              "title": "Test Article",
              "description": "This is a test article.",
              "url": "https://example.com/test-article",
              "publishedAt": "2025-11-11T00:00:00Z",
              "content": "Test content"
            }
          ]
        }
        """.data(using: .utf8)!
    
    static let successResponse: URLResponse = HTTPURLResponse(
        url: URL(string: "https://test.com")!,
        statusCode: 200,
        httpVersion: nil,
        headerFields: nil
    )!
    
    static let badRequestResponse: URLResponse = HTTPURLResponse(
        url: URL(string: "https://test.com")!,
        statusCode: 400,
        httpVersion: nil,
        headerFields: nil
    )!
}
