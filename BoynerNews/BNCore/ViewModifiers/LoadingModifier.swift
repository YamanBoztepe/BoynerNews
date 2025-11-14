//
//  LoadingModifier.swift
//  BoynerNews
//
//  Created by Yaman Boztepe on 11.11.2025.
//

import SwiftUI

struct LoadingModifier: ViewModifier {
    let isLoading: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .disabled(isLoading)
                .blur(radius: isLoading ? 2 : 0)
            
            if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .primary))
                    .scaleEffect(1.5)
                    .transition(.opacity)
            }
        }
        .animation(.easeInOut, value: isLoading)
    }
}

// MARK: - View Extension

extension View {
    func isLoading(_ loading: Bool) -> some View {
        modifier(LoadingModifier(isLoading: loading))
    }
}
