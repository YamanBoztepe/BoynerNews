//
//  ArticlesRepository.swift
//  BoynerNews
//
//  Created by Yaman Boztepe on 11.11.2025.
//

import Foundation
import CoreData

protocol ArticlesRepositoryProtocol {
    func addArticle(_ articleId: String)
    func removeArticle(_ articleId: String)
    func isArticleExists(_ articleId: String) -> Bool
}

final class ArticlesRepository: ArticlesRepositoryProtocol {
    
    private let container: NSPersistentContainer
    
    private var context: NSManagedObjectContext {
        container.viewContext
    }
    
    init(container: NSPersistentContainer = PersistenceController.shared.container) {
        self.container = container
    }
    
    func addArticle(_ articleId: String) {
        guard !isArticleExists(articleId) else {
            return
        }
        
        let item = Articles(context: context)
        item.id = articleId
        saveContext()
    }
    
    func removeArticle(_ articleId: String) {
        let request = Articles.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", articleId)
        
        if let items = try? context.fetch(request) {
            items.forEach { context.delete($0) }
            saveContext()
        }
    }
    
    func isArticleExists(_ articleId: String) -> Bool {
        let request = Articles.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", articleId)
        request.fetchLimit = 1
        
        if let count = try? context.count(for: request) {
            return count > 0
        }
        
        return false
    }
    
    private func saveContext() {
        guard context.hasChanges else {
            return
        }
        
        do {
            try context.save()
        } catch {
            print("Failed to save: \(error)")
        }
    }
    
}
