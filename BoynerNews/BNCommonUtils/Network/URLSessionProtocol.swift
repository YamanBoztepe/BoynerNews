//
//  URLSessionProtocol.swift
//  BoynerNews
//
//  Created by Yaman Boztepe on 11.11.2025.
//

import Foundation

protocol URLSessionProtocol {
    func data(from url: URL) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {}
