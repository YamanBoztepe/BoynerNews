//
//  Array+Extensions.swift
//  BoynerNews
//
//  Created by Yaman Boztepe on 11.11.2025.
//

protocol EmptyValueRepresentable {
    static var emptyValue: Self { get }
}

extension Array: EmptyValueRepresentable {
    static var emptyValue: [Element] { return [] }
}

extension Optional where Wrapped: EmptyValueRepresentable {

    var valueOrEmpty: Wrapped {
        switch self {
        case .some(let value):
            return value
        case .none:
            return Wrapped.emptyValue
        }
    }
}
