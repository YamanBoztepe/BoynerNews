//
//  FakeArticlesRepository.swift
//  BoynerNews
//
//  Created by Yaman Boztepe on 11.11.2025.
//

@testable import BoynerNews

final class FakeArticlesRepository: ArticlesRepositoryProtocol {
    var addArticleCalled = false
    var removeArticleCalled = false
    var isArticleExistsCalled = false
    
    var isArticleExists = false
    
    func addArticle(_ articleId: String) {
        addArticleCalled = true
    }
    
    func removeArticle(_ articleId: String) {
        removeArticleCalled = true
    }
    
    func isArticleExists(_ articleId: String) -> Bool {
        isArticleExistsCalled = true
        return isArticleExists
    }
}
