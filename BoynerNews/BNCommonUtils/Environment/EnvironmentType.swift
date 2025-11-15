//
//  EnvironmentType.swift
//  BoynerNews
//
//  Created by Yaman Boztepe on 11.11.2025.
//

enum EnvironmentType {
    case prod
    case dummyData
}

extension EnvironmentType {
    
    var host: String {
        switch self {
        case .prod:
            return NetworkConstants.BaseURL.release.rawValue
        case .dummyData:
            return NetworkConstants.BaseURL.dummyData.rawValue
        }
    }
}
