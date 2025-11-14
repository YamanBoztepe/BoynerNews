//
//  TitleAndDescriptionView.swift
//  BoynerNews
//
//  Created by Yaman Boztepe on 11.11.2025.
//

import SwiftUI

struct TitleAndDescriptionView: View {
    let title: String
    let description: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(title)
                .font(.headline)
                .foregroundStyle(.primary)
            Text(description)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    TitleAndDescriptionView(title: "ABC News (AU)",
                            description: "Australia's most trusted source of local, national and world news.")
}
