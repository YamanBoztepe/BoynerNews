//
//  ConfigValueReader.swift
//  BoynerNews
//
//  Created by Yaman Boztepe on 16.11.2025.
//

import Foundation

enum ConfigValueReader {
    
    static func string(forKey key: String) -> String {
        guard let value = Bundle.main.object(forInfoDictionaryKey: key) as? String else {
            fatalError("\(key) could not be found in Info.plist.")
        }
        
        return value
    }
}
