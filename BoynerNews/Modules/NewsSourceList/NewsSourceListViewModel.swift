//
//  NewsSourceListViewModel.swift
//  BoynerNews
//
//  Created by Yaman Boztepe on 11.11.2025.
//

import Combine

final class NewsSourceListViewModel: BaseViewModel {
    @Published var sources = [NewsSourceList.Source]()
    @Published var noSourcesFound = false
    @Published var categories = [String]()
    @Published var selectedCategories = [String]() {
        didSet {
            filterSourcesBySelectedCategories()
        }
    }
    
    private var allSources = [NewsSourceList.Source]()
    
    func getNewsSources() async {
        let request = BNServiceRequest(endpoint: .sources)
        let response = await callService(request, responseType: NewsSourceList.SourcesResponse.self)
        
        // Keep only English sources
        let newsSources = (response?.sources?.filter { $0.language == "en" }).valueOrEmpty
        allSources = newsSources
        
        // Extract unique categories
        categories = Array(Set(newsSources.map { $0.category.stringValue })).sorted()
        
        // Apply filter if there are selected categories
        filterSourcesBySelectedCategories()
        noSourcesFound = sources.isEmpty
    }
    
    private func filterSourcesBySelectedCategories() {
        if selectedCategories.isEmpty {
            sources = allSources
        } else {
            sources = allSources.filter { source in
                selectedCategories.contains(source.category.stringValue)
            }
        }
    }
}
