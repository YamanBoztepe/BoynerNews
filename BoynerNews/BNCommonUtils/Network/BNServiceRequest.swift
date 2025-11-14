//
//  BNServiceRequest.swift
//  BoynerNews
//
//  Created by Yaman Boztepe on 11.11.2025.
//

struct BNServiceRequest {
    var endpoint: NetworkConstants.Endpoints
    var parameters: [String: String] = [:]
}
