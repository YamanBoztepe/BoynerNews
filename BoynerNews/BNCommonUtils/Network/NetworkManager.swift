//
//  NetworkManager.swift
//  BoynerNews
//
//  Created by Yaman Boztepe on 11.11.2025.
//

import Foundation

protocol NetworkServiceProtocol {
    func callService<T: Decodable>(_ request: BNServiceRequest, responseType: T.Type) async -> Result<T, NetworkError>
}

nonisolated final class NetworkManager: NetworkServiceProtocol {
    
    private let session: URLSessionProtocol
    private let decoder: JSONDecoder
    private let environment: EnvironmentType
    
    init(session: URLSessionProtocol = URLSession.shared,
         decoder: JSONDecoder = JSONDecoder(),
         environment: EnvironmentType = .release) {
        self.session = session
        self.decoder = decoder
        self.environment = environment
    }
    
    func callService<T: Decodable>(_ request: BNServiceRequest, responseType: T.Type) async -> Result<T, NetworkError> {
        // Making URL according to given request
        guard let url = makeURL(from: request) else {
            return .failure(.invalidURL)
        }
        
        do {
            // Getting raw data and url response
            let (data, response) = try await session.data(from: url)
            
            // Check if HTTP status code is OK
            if let error = validateHTTPResponse(response, data: data) {
                return .failure(error)
            }
            
            // Decoding raw data to given response model and check if response status is ok
            return try validateAPIResponse(data: data, type: T.self)
            
        } catch _ as DecodingError {
            return .failure(.decodingError)
        } catch {
            return .failure(.unknownError(error.localizedDescription))
        }
    }
}

// MARK: - Helpers
private extension NetworkManager {
    
    func makeURL(from request: BNServiceRequest) -> URL? {
        var components = URLComponents(string: environment.host.appending(request.endpoint.rawValue))
        var parameters = request.parameters
        parameters["apiKey"] = NetworkConstants.apiKey
        components?.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        return components?.url
    }
    
    func validateHTTPResponse(_ response: URLResponse?, data: Data) -> NetworkError? {
        guard let httpResponse = response as? HTTPURLResponse else {
            return .serverError
        }
        
        guard 200..<300 ~= httpResponse.statusCode else {
            if let errorResponse = try? decoder.decode(BaseErrorResponse.self, from: data),
               let message = errorResponse.message {
                return .unknownError(message)
            } else {
                return .serverError
            }
        }
        
        return nil
    }
    
    func validateAPIResponse<T: Decodable & Sendable>(data: Data, type: T.Type) throws -> Result<T, NetworkError> {
        let statusResponse = try decoder.decode(BaseStatusResponse.self, from: data)
        
        switch statusResponse.status {
        case .ok:
            let result = try decoder.decode(T.self, from: data)
            return .success(result)
        case .error:
            let errorResponse = try decoder.decode(BaseErrorResponse.self, from: data)
            return .failure(.unknownError(errorResponse.message ?? "Unknown API error"))
        }
    }
}
