//
//  NetworkManagerTests.swift
//  BoynerNews
//
//  Created by Yaman Boztepe on 11.11.2025.
//

import XCTest
@testable import BoynerNews

final class NetworkManagerTests: CommonXCTestCase {
    private let request = BNServiceRequest(endpoint: .topHeadlines, parameters: [:])
    
    // MARK: Subject under test
    
    var sut: NetworkManager!
    
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        sut = NetworkManager(session: fakeURLSession, environment: .test)
    }
    
    override func tearDown() {
        sut = nil
        fakeURLSession.fakeData = nil
        fakeURLSession.fakeResponse = nil
        fakeURLSession.fakeError = nil
        super.tearDown()
    }
    
    // MARK: - Tests
    
    func test_request_whenURLInvalid_shoulReturnError() async {
        // Given
        sut = NetworkManager(session: fakeURLSession, environment: .mock)
        
        // When
        let result = await sut.callService(request, responseType: String.self)
        
        // Then
        if case let .failure(error) = result {
            XCTAssertEqual(error, .invalidURL)
        } else {
            XCTFail("Expected invalidURL error but got success")
        }
    }
    
    func test_request_whenURLResponseInvalid_shoulReturnError() async {
        // When
        let result = await sut.callService(request, responseType: String.self)
        
        // Then
        if case let .failure(error) = result {
            XCTAssertEqual(error, .serverError)
        } else {
            XCTFail("Expected serverError error but got success")
        }
    }
    
    func test_request_whenURLResponseStatusCodeInvalid_shoulReturnError() async {
        // Given
        fakeURLSession.fakeResponse = NetworkManagerMockData.badRequestResponse
        
        // When
        let result = await sut.callService(request, responseType: String.self)
        
        // Then
        if case let .failure(error) = result {
            XCTAssertEqual(error, .serverError)
        } else {
            XCTFail("Expected serverError error but got success")
        }
    }
    
    func test_request_whenDecodingInvalid_shoulReturnError() async {
        // Given
        fakeURLSession.fakeResponse = NetworkManagerMockData.successResponse
        fakeURLSession.fakeData = NetworkManagerMockData.data
        
        // When
        let result = await sut.callService(request, responseType: String.self)
        
        // Then
        if case let .failure(error) = result {
            XCTAssertEqual(error, .decodingError)
        } else {
            XCTFail("Expected decodingError error but got success")
        }
        
    }
    
    @MainActor
    func test_request_whenSucceed_shouldReturnResponse() async {
        // Given
        fakeURLSession.fakeResponse = NetworkManagerMockData.successResponse
        fakeURLSession.fakeData = NetworkManagerMockData.data
        
        // When
        let result = await sut.callService(request, responseType: NewsList.ArticlesResponse.self)
        
        // Then
        if case let .success(data) = result {
            XCTAssertEqual(data.articles?.count, 1)
        } else {
            XCTFail("Expected success but got failure")
        }
    }
}

