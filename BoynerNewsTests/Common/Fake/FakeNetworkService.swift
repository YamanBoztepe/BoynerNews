//
//  FakeNetworkService.swift
//  BoynerNews
//
//  Created by Yaman Boztepe on 11.11.2025.
//

@testable import BoynerNews

nonisolated final class FakeNetworkService: NetworkServiceProtocol {
    
    var result: Result<Any, NetworkError>?
    
    func callService<T>(_ request: BNServiceRequest, responseType: T.Type) async -> Result<T, NetworkError> where T: Decodable {
        switch result {
        case .success(let success):
            return .success(success as! T)
        case .failure(let failure):
            return .failure(failure)
        case nil:
            return .failure(.unknownError("Type mismatch"))
        }
    }
}
