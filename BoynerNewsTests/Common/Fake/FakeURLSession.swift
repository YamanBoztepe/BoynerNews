//
//  FakeURLSession.swift
//  BoynerNews
//
//  Created by Yaman Boztepe on 11.11.2025.
//

import Foundation
@testable import BoynerNews

final class FakeURLSession: URLSessionProtocol {
    var fakeData: Data?
    var fakeResponse: URLResponse?
    var fakeError: Error?

    func data(from url: URL) async throws -> (Data, URLResponse) {
        if let error = fakeError {
            throw error
        }
        
        return (fakeData ?? Data(), fakeResponse ?? URLResponse())
    }
}


