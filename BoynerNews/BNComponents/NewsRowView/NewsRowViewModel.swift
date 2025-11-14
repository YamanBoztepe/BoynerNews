//
//  NewsRowViewModel.swift
//  BoynerNews
//
//  Created by Yaman Boztepe on 12.11.2025.
//

struct NewsRowViewModel: Identifiable {
    let id: String
    let title: String
    let date: String
    let imageURL: String
    var isAddedToReadingList: Bool
    let onToggleReadingList: (String) -> Void
}
