//
//  NewsListView.swift
//  BoynerNews
//
//  Created by Yaman Boztepe on 11.11.2025.
//

import SwiftUI

struct NewsListView: View {
    @StateObject private var viewModel = ViewModel()
    let source: String
    
    var body: some View {
        List {
            sliderSection
            recommendationSection
        }
        .listStyle(.plain)
        .navigationTitle(viewModel.screenTitle)
        .navigationBarTitleDisplayMode(.inline)
        .task { await viewModel.getNews(for: source) }
        .refreshable { await viewModel.pullToRefresh() }
        .onAppear(perform: viewModel.startPolling)
        .onDisappear(perform: viewModel.stopPolling)
        .presentEmptyPlaceholder(viewModel.noArticlesFound,
                                 message: NewsList.emptyListMessage)
        .isLoading(viewModel.isLoading)
        .presentAlert(alert: $viewModel.alert)
    }
    
    @ViewBuilder
    var sliderSection: some View {
        if !viewModel.sliderArticles.isEmpty {
            Section(NewsList.breakingNewsSectionTitle) {
                SliderView(items: viewModel.sliderArticles) { article in
                    NewsRowView(model: article)
                }
                .frame(height: NewsList.breakingNewsSectionHeight)
            }
        }
    }
    
    @ViewBuilder
    var recommendationSection: some View {
        if !viewModel.listArticles.isEmpty {
            Section(NewsList.recommendationsSectionTitle) {
                ForEach(viewModel.listArticles) { article in
                    NewsRowView(model: article)
                }
                .listRowSeparator(.hidden)
            }
        }
    }
}

#Preview {
    NewsListView(source: "bbc-news")
}
