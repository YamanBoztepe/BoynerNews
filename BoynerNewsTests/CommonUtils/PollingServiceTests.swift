//
//  PollingServiceTests.swift
//  BoynerNews
//
//  Created by Yaman Boztepe on 14.11.2025.
//

import XCTest
@testable import BoynerNews

@MainActor
final class PollingServiceTests: CommonXCTestCase {
    // MARK: Subject under test
    
    var sut: PollingService!
    
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        sut = PollingService()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    // MARK: - Tests
    
    func test_startPolling_callsOnUpdateRepeatedly() {
        // Given
        let expectation = expectation(description: "onUpdate should be called twice")
        expectation.expectedFulfillmentCount = 2
        
        var callCount = 0
        
        // When
        sut.startPolling(interval: 0.1) {
            callCount += 1
            expectation.fulfill()
        }
        
        // Then
        wait(for: [expectation], timeout: 1)
        XCTAssertEqual(callCount, 2)
    }
    
    func test_stopPolling_stopsTimer() {
        // Given
        let expectation = expectation(description: "onUpdate should not be called")
        expectation.isInverted = true
        
        // When
        sut.startPolling(interval: 0.1) {
            expectation.fulfill()
        }
        sut.stopPolling()
        
        // Then
        wait(for: [expectation], timeout: 1)
    }
}
