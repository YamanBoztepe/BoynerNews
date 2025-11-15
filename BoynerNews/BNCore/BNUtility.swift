//
//  BNUtility.swift
//  BoynerNews
//
//  Created by Yaman Boztepe on 15.11.2025.
//

import Foundation

final class BNUtility {
    static var isRunningUnitTests: Bool {
#if DEBUG
        return ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil
#else
        return false
#endif
    }
    
    static var isRunningUITests: Bool {
#if DEBUG
        return ProcessInfo.processInfo.arguments.contains("-UITesting")
#else
        return false
#endif
    }
}
