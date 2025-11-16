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
        List {
            categorySection
            sourceList
        }
        .listStyle(.plain)
        .accessibilityIdentifier(Identifiers.NewsSourceList.list)
        .task { await viewModel.getNewsSources() }
        .navigationTitle(NewsSourceList.title)
        .animation(.smooth, value: viewModel.selectedCategories)
        .presentEmptyPlaceholder(viewModel.presentEmptyState,
                                 message: NewsSourceList.emptyListMessage)
        .isLoading(viewModel.isLoading)
        .presentAlert(alert: $viewModel.alert)
    }
}

// MARK: - Views

private extension NewsSourceListView {
    
    var categorySection: some View {
        Section {
            HorizontalScrollItemsView(items: viewModel.categories,
                                      selectedItems: $viewModel.selectedCategories)
        }
        .listRowInsets(NewsSourceList.categorySectionInsets)
        .listRowSeparator(.hidden)
        .accessibilityIdentifier(Identifiers.NewsSourceList.categories)
    }
    
    var sourceList: some View {
        ForEach(viewModel.sources) { source in
            NavigationLink(destination: NewsListView(source: source.id.stringValue)) {
                TitleAndDescriptionView(title: source.name.stringValue,
                                        description: source.description.stringValue)
            }
            .buttonStyle(.plain)
        }
    }
}

#Preview {
    NewsSourceListView()
}
