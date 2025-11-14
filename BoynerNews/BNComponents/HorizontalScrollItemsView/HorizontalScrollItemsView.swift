//
//  HorizontalScrollItemsView.swift
//  BoynerNews
//
//  Created by Yaman Boztepe on 11.11.2025.
//

import SwiftUI

struct HorizontalScrollItemsView: View {
    let items: [String]
    @Binding var selectedItems: [String]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(items, id: \.self) { item in
                    makeItemView(for: item)
                }
            }
        }
    }
}

#Preview {
    HorizontalScrollItemsView(items: [
        "Politics", "Business", "Technology", "Sports", "Entertainment",
        "Health", "Science", "Travel", "Lifestyle", "World"
    ], selectedItems: .constant(["Business", "Technology"]))
}
