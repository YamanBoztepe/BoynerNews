//
//  NetworkFactory.swift
//  BoynerNews
//
//  Created by Yaman Boztepe on 15.11.2025.
//

import Foundation

final class NetworkFactory {
    
    static func makeNetworkManager() -> NetworkServiceProtocol {
        let environmentType = EnvironmentService.shared.environmentType
        
        switch environmentType {
        case .prod:
            return NetworkManager(environment: .prod, session: URLSession.shared)
            
        case .dummyData:
            return MockNetworkManager()
        }
    }
}
