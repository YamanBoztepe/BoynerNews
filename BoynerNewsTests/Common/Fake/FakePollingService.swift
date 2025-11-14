//
//  FakePollingService.swift
//  BoynerNews
//
//  Created by Yaman Boztepe on 14.11.2025.
//

@testable import BoynerNews
import Foundation

final class FakePollingService: PollingServiceProtocol {
    var startPollingCalled = false
    var stopPollingCalled = false
    
    func startPolling(interval: TimeInterval, onUpdate: @escaping () -> Void) {
        startPollingCalled = true
    }
    
    func stopPolling() {
        stopPollingCalled = true
    }
}
