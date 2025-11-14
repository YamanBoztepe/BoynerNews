//
//  EnvironmentType.swift
//  BoynerNews
//
//  Created by Yaman Boztepe on 11.11.2025.
//

enum EnvironmentType {
    case release
    case test
    case mock
    
    var host: String {
        switch self {
        case .release, .test:
            return NetworkConstants.BaseURL.release.rawValue
        case .mock:
            return NetworkConstants.BaseURL.mock.rawValue
        }
    }
}
