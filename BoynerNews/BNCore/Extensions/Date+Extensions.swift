//
//  Date+Extensions.swift
//  BoynerNews
//
//  Created by Yaman Boztepe on 12.11.2025.
//

import Foundation

extension Date {
    func toString(dateStyle: DateFormatter.Style = .medium, timeStyle: DateFormatter.Style = .short) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = dateStyle
        formatter.timeStyle = timeStyle
        return formatter.string(from: self)
    }
}
