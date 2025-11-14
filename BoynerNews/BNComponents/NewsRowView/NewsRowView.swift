//
//  NewsRowView.swift
//  BoynerNews
//
//  Created by Yaman Boztepe on 12.11.2025.
//

import SwiftUI

struct NewsRowView: View {
    let model: NewsRowViewModel
    
    var body: some View {
        HStack(alignment: .top) {
            imageView
            VStack(alignment: .leading, spacing: 8) {
                titleLabelView
                dateLabelView
                addToReadingListButton
            }
        }
    }
}

#Preview {
    NewsRowView(model: .init(id: "1",
                             title: "New Bitcoin Protocol Makes Payments Easier",
                             date: "28 May, 11:25",
                             imageURL: "https://gizmodo.com/app/uploads/2024/04/0ddbd47a359dbefbb14c16d0ffe99a95.jpg",
                             isAddedToReadingList: true) { _ in })
}
