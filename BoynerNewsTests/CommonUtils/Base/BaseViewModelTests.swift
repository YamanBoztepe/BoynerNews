//
//  BaseViewModelTests.swift
//  BoynerNews
//
//  Created by Yaman Boztepe on 11.11.2025.
//

import XCTest
@testable import BoynerNews

@MainActor
final class BaseViewModelTests: CommonXCTestCase {
    private let request = BNServiceRequest(endpoint: .topHeadlines, parameters: [:])
    
    // MARK: Subject under test
    
    var sut: BaseViewModel!
    
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        sut = BaseViewModel()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    // MARK: - Tests
    
    func test_request_whenSucceed_shouldReturnResponse() async {
        // When
        let response = await sut.callService(request, responseType: NewsList.ArticlesResponse.self)
        
        // Then
        XCTAssertNotNil(response)
        XCTAssertNil(sut.alert)
    }
    
    func test_request_whenFailed_shouldDisplayAlert() async {
        // Given
        let service = sut.service as? MockNetworkManager
        service?.scenario = .serverErrorFailure
        
        
        // When
        let response = await sut.callService(request, responseType: NewsList.ArticlesResponse.self)
        
        // Then
        XCTAssertEqual((sut.alert?.title).stringValue, NetworkError.serverError.localizedDescription)
        XCTAssertNil(response)
    }
}
