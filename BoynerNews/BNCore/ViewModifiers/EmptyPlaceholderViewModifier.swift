//
//  EmptyPlaceholderViewModifier.swift
//  BoynerNews
//
//  Created by Yaman Boztepe on 13.11.2025.
//

import SwiftUI

struct EmptyPlaceholderViewModifier: ViewModifier {
    let present: Bool
    let message: String
    let image: String?
    
    func body(content: Content) -> some View {
        ZStack {
            content
            
            if present {
                emptyPlaceholderView
            }
        }
    }
}

// MARK: - Views

private extension EmptyPlaceholderViewModifier {
    
    var emptyPlaceholderView: some View {
        VStack {
            Image(image ?? "exclamationMark")
                .font(.system(size: 40))
                .foregroundStyle(.secondary)
                .padding(.bottom, 16)
            
            Text(message)
                .foregroundStyle(.primary)
                .font(.headline)
        }
    }
}

// MARK: - EmptyPlaceholderViewModifier

extension View {
    func presentEmptyPlaceholder(_ present: Bool, message: String, image: String? = nil) -> some View {
        modifier(EmptyPlaceholderViewModifier(present: present, message: message, image: image))
    }
}
