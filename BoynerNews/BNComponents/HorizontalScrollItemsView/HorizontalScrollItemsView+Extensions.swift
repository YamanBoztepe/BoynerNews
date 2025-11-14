//
//  HorizontalScrollItemsView+Extensions.swift
//  BoynerNews
//
//  Created by Yaman Boztepe on 12.11.2025.
//

import SwiftUI

// MARK: - Views

extension HorizontalScrollItemsView {
    
    func makeItemView(for item: String) -> some View {
        Button {
            selectItem(item)
        } label: {
            Text(item)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(isSelected(item) ? Color.blue : Color.primary.opacity(0.1))
                )
                .foregroundStyle(isSelected(item) ? Color.white : Color.primary.opacity(0.3))
        }
    }
}

// MARK: - Helper Methods

private extension HorizontalScrollItemsView {
    func isSelected(_ item: String) -> Bool {
        selectedItems.contains(item)
    }
    
    func selectItem(_ item: String) {
        if let index = selectedItems.firstIndex(of: item) {
            selectedItems.remove(at: index)
        } else {
            selectedItems.append(item)
        }
    }
}
