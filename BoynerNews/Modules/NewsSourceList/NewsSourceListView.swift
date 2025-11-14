//
//  NewsSourceListView.swift
//  BoynerNews
//
//  Created by Yaman Boztepe on 11.11.2025.
//

import SwiftUI

struct NewsSourceListView: View {
    @StateObject private var viewModel = NewsSourceListViewModel()
    
    var body: some View {
        VStack(spacing: 24) {
            categoryBubbles
            newsSourceList
        }
        .padding(.top)
        .task { await viewModel.getNewsSources() }
        .navigationTitle(NewsSourceList.title)
        .animation(.smooth, value: viewModel.selectedCategories)
        .presentEmptyPlaceholder(viewModel.noSourcesFound,
                                 message: NewsSourceList.emptyListMessage)
        .isLoading(viewModel.isLoading)
        .presentAlert(alert: $viewModel.alert)
    }
}

// MARK: - Views

private extension NewsSourceListView {
    
    var categoryBubbles: some View {
        HorizontalScrollItemsView(items: viewModel.categories,
                                  selectedItems: $viewModel.selectedCategories)
        .accessibilityIdentifier(Identifiers.NewsSourceList.categories)
    }
    
    var newsSourceList: some View {
        List(viewModel.sources) { source in
            NavigationLink(destination: NewsListView(source: source.id.stringValue)) {
                TitleAndDescriptionView(title: source.name.stringValue,
                                        description: source.description.stringValue)
            }
            .buttonStyle(.plain)
        }
        .listStyle(.plain)
        .accessibilityIdentifier(Identifiers.NewsSourceList.list)
    }
}

#Preview {
    NewsSourceListView()
}
