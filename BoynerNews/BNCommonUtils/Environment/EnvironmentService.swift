//
//  EnvironmentService.swift
//  BoynerNews
//
//  Created by Yaman Boztepe on 15.11.2025.
//

import Foundation

/// `EnvironmentService` is responsible for getting current environment
/// `Dummy Data` Replacing configurations to mock versions for Unit and UI Tests
/// `PROD` Production
final class EnvironmentService: EnvironmentProtocol {
    
    static let shared = EnvironmentService()
    
    var environmentType: EnvironmentType {
        getEnvironmentType()
    }
    
    private init() { }
}

// MARK: - Helpers

private extension EnvironmentService {
    func getEnvironmentType() -> EnvironmentType {
#if DEBUG
        if BNUtility.isRunningUnitTests || BNUtility.isRunningUITests {
            return .dummyData
        }
        
        return .prod
        
#else
        return .prod
#endif
    }
}
