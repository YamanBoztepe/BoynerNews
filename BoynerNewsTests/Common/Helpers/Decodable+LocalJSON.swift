//
//  Decodable+LocalJSON.swift
//  BoynerNews
//
//  Created by Yaman Boztepe on 15.11.2025.
//

import Foundation

extension Decodable {
    static func parse(jsonFile: String) -> Self? {
        guard let url = Bundle.main.url(forResource: jsonFile, withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let output = try? JSONDecoder().decode(self, from: data) else {
            return nil
        }
        
        return output
    }
}
