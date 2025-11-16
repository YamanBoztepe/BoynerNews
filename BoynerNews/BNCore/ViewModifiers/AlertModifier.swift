//
//  AlertModifier.swift
//  BoynerNews
//
//  Created by Yaman Boztepe on 12.11.2025.
//

import SwiftUI

struct AlertModifier: ViewModifier {
    @Binding var alert: AlertModel?

    func body(content: Content) -> some View {
        ZStack {
            content

            if let alert {
                tappableBackground
                makeAlertCard(alert: alert)
                    .frame(maxWidth: 500)
                    .padding(.horizontal, 20)
                    .transition(.scale.combined(with: .opacity))
            }
        }
        .animation(.spring(), value: alert != nil)
    }
}

// MARK: - Views

private extension AlertModifier {

    var tappableBackground: some View {
        Color.black.opacity(0.2)
            .ignoresSafeArea()
            .onTapGesture {
                self.alert = nil
            }
    }

    func makeAlertCard(alert: AlertModel) -> some View {
        VStack(spacing: 24) {
            Text(alert.title)
                .foregroundStyle(.primary)
                .font(.headline)

            ForEach(alert.buttons) { button in
                Button {
                    button.action()
                    self.alert = nil
                } label: {
                    Text(button.title)
                        .foregroundStyle(.white)
                        .font(.body)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(12)
                }
            }
        }
        .padding(32)
        .background(.ultraThinMaterial)
        .cornerRadius(20)
        .shadow(radius: 10)
    }
}

// MARK: - View Extension

extension View {
    func presentAlert(alert: Binding<AlertModel?>) -> some View {
        modifier(AlertModifier(alert: alert))
    }
}

// MARK: - Models

struct AlertModel {
    let title: String
    let buttons: [AlertButton]
}

struct AlertButton: Identifiable {
    let id = UUID()
    let title: String
    let action: () -> Void
}
