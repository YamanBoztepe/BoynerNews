//
//  BaseResponse.swift
//  BoynerNews
//
//  Created by Yaman Boztepe on 11.11.2025.
//

import Foundation

enum APIStatus: String, Decodable {
    case ok
    case error
}

struct BaseStatusResponse: Decodable {
    let status: APIStatus
}

struct BaseErrorResponse: Decodable {
    let status: APIStatus
    let message: String?
}
