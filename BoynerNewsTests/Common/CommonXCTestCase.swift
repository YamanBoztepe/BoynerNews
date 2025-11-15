//
//  CommonXCTestCase.swift
//  BoynerNews
//
//  Created by Yaman Boztepe on 11.11.2025.
//

import XCTest
@testable import BoynerNews

class CommonXCTestCase: XCTestCase {
    let fakeURLSession = FakeURLSession()
    let fakeArticleRepository = FakeArticlesRepository()
    let fakePollingService = FakePollingService()
}
