//
//  PollingService.swift
//  BoynerNews
//
//  Created by Yaman Boztepe on 14.11.2025.
//

import Combine
import Foundation

protocol PollingServiceProtocol {
    func startPolling(interval: TimeInterval, onUpdate: @escaping () -> Void)
    func stopPolling()
}

class PollingService: PollingServiceProtocol {
    private var timer: Timer?
    
    func startPolling(interval: TimeInterval, onUpdate: @escaping () -> Void) {
        stopPolling()
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { _ in
            onUpdate()
        }
    }
    
    func stopPolling() {
        timer?.invalidate()
        timer = nil
    }
    
    deinit {
        stopPolling()
    }
}
