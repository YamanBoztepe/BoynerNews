//
//  MockNetworkManager.swift
//  BoynerNews
//
//  Created by Yaman Boztepe on 15.11.2025.
//

#if DEBUG

import Foundation

/// `MockNetworkManager` Handles mock network calls.
/// `scenario` Force specific mock behavior.
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
    
    /// Reads JSON file for the endpoint and decode to given model.
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
    
    /// Determines the active mock scenario from launch arguments or property.
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
