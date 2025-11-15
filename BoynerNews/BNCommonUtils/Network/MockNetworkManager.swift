//
//  MockNetworkManager.swift
//  BoynerNews
//
//  Created by Yaman Boztepe on 15.11.2025.
//

#if DEBUG

import Foundation

nonisolated final class MockNetworkManager: NetworkServiceProtocol {
    
    var scenario: MockScenario?
    
    func callService<T>(_ request: BNServiceRequest, responseType: T.Type) async -> Result<T, NetworkError> where T: Decodable {
        
        if case .serverErrorFailure = checkScenario() {
            return .failure(.serverError)
        }
        
        return responseData(for: request.endpoint.rawValue)
    }
}

// MARK: - Helpers

private extension MockNetworkManager {
    
    func responseData<T>(for endpoint: String) -> Result<T, NetworkError> where T: Decodable {
        let fileName = endpoint.replacingOccurrences(of: "/", with: "_")
        
        guard let url = Bundle.main.url(forResource: fileName,
                                        withExtension: "json") else {
            return .failure(.unknownError("Mock JSON file not found: \(fileName)"))
        }
        
        do {
            let data = try Data(contentsOf: url)
            let model = try JSONDecoder().decode(T.self, from: data)
            return .success(model)
        } catch {
            return .failure(.decodingError)
        }
    }
    
    func checkScenario() -> MockScenario? {
        let arguments = ProcessInfo.processInfo.arguments
        var scenarioFromArguments: MockScenario?
        
        if arguments.contains(MockScenario.serverErrorFailure.rawValue) {
            scenarioFromArguments = .serverErrorFailure
        }
        
        return scenario ?? scenarioFromArguments
    }
}

// MARK: - MockScenario

enum MockScenario: String {
    case serverErrorFailure = "-MockScenario_Failure_ServerError"
}

#endif
