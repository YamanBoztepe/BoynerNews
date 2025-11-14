//
//  SliderView.swift
//  BoynerNews
//
//  Created by Yaman Boztepe on 13.11.2025.
//

import SwiftUI

struct SliderView<Data: RandomAccessCollection, Content: View>: View where Data.Element: Identifiable {
    let items: Data
    let interval: TimeInterval = 5
    @ViewBuilder let content: (Data.Element) -> Content
    
    @State private var currentIndex = 0
    @State private var timer: Timer?
    
    var body: some View {
        VStack {
            TabView(selection: $currentIndex) {
                ForEach(Array(items.enumerated()), id: \.1.id) { index, item in
                    content(item)
                        .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            
            progressBar
        }
        .onAppear(perform: startTimer)
        .onDisappear(perform: stopTimer)
    }
    
    var progressBar: some View {
        VStack(spacing: 4) {
            Text("\(currentIndex + 1)/\(items.count)")
                .font(.caption)
                .foregroundColor(.secondary)
            
            ProgressView(value: Double(currentIndex), total: Double(items.count - 1))
                .progressViewStyle(LinearProgressViewStyle(tint: .primary))
                .animation(.linear, value: currentIndex)
        }
        .padding(.horizontal)
    }
}

// MARK: - Helper Methods

extension SliderView {
    
    func startTimer() {
        stopTimer()
        guard items.count > 1 else {
            return
        }
        
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { _ in
            withAnimation {
                currentIndex = (currentIndex + 1) % items.count
            }
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}

#Preview {
    let sampleArticles = [
        NewsRowViewModel(id: "1",
                         title: "New Bitcoin Protocol Makes Payments Easier",
                         date: "28 May, 11:25",
                         imageURL: "https://gizmodo.com/app/uploads/2024/04/0ddbd47a359dbefbb14c16d0ffe99a95.jpg",
                         isAddedToReadingList: true,
                         onToggleReadingList: { _ in }),
        NewsRowViewModel(id: "2",
                         title: "Apple Launches New MacBook Model",
                         date: "27 May, 15:10",
                         imageURL: "https://picsum.photos/400/200",
                         isAddedToReadingList: false,
                         onToggleReadingList: { _ in }),
        NewsRowViewModel(id: "3",
                         title: "Global Markets Rally Today",
                         date: "26 May, 09:45",
                         imageURL: "https://picsum.photos/401/200",
                         isAddedToReadingList: true,
                         onToggleReadingList: { _ in })
    ]
    
    SliderView(items: sampleArticles) { article in
        NewsRowView(model: article)
    }
}
