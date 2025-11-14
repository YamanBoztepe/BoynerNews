//
//  String+Extensions.swift
//  BoynerNews
//
//  Created by Yaman Boztepe on 11.11.2025.
//

import Foundation

extension String {
    
    /// Converts an ISO8601 string to a Date. Supports both fractional and non-fractional seconds.
    var isoStringToDate: Date? {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return formatter.date(from: self) ?? ISO8601DateFormatter().date(from: self)
    }
}

extension Optional where Wrapped == String {
    var stringValue: String {
        self ?? ""
    }
}
