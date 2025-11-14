//
//  NewsRowView+Extensions.swift
//  BoynerNews
//
//  Created by Yaman Boztepe on 12.11.2025.
//

import SwiftUI

// MARK: - Views

extension NewsRowView {
    
    private var buttonTitle: String {
        model.isAddedToReadingList ? "Remove from reading list" : "Add to my reading list"
    }
    
    var imageView: some View {
        AsyncImage(url: URL(string: model.imageURL)) { image in
            image.resizable()
        } placeholder: {
            ProgressView()
        }
        .frame(width: 150, height: 100)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
    
    var titleLabelView: some View {
        Text(model.title)
            .font(.body)
            .foregroundColor(.primary)
    }
    
    var dateLabelView: some View {
        Text(model.date)
            .font(.caption)
            .foregroundColor(.secondary)
    }
    
    var addToReadingListButton: some View {
        Button {
            model.onToggleReadingList(model.id)
        } label: {
            Text(buttonTitle)
                .font(.caption)
                .foregroundColor(.blue)
                .padding(.vertical, 4)
                .padding(.horizontal, 8)
                .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}
