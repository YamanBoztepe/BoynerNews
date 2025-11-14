//
//  ArticlesRepositoryTests.swift
//  BoynerNews
//
//  Created by Yaman Boztepe on 11.11.2025.
//

import XCTest
import CoreData
@testable import BoynerNews

final class ArticlesRepositoryTests: CommonXCTestCase {
    
    var container: NSPersistentContainer!
    
    // MARK: Subject under test
    
    var sut: ArticlesRepository!
    
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        setupContainer()
        sut = ArticlesRepository(container: container)
    }
    
    override func tearDown() {
        sut = nil
        container = nil
        super.tearDown()
    }
    
    private func setupContainer() {
        container = NSPersistentContainer(name: "BoynerNews")
        
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        description.shouldAddStoreAsynchronously = false
        
        container.persistentStoreDescriptions = [description]
        
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                XCTFail("\(error)")
            }
        }
        
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    // MARK: - Tests
    
    func test_addArticle() {
        // Given
        let articleId = "testArticle123"
        
        // When
        sut.addArticle(articleId)
        
        // Then
        XCTAssertTrue(sut.isArticleExists(articleId))
    }
    
    func test_removeArticle() {
        // Given
        let articleId = "testArticle123"
        sut.addArticle(articleId)
        
        // When
        sut.removeArticle(articleId)
        
        // Then
        XCTAssertFalse(sut.isArticleExists(articleId))
    }
    
    func test_removeArticle_whenItsNotExists() {
        // Given
        let articleId = "nonExistentArticle"
        
        // When
        sut.removeArticle(articleId)
        
        // Then
        XCTAssertFalse(sut.isArticleExists(articleId))
    }
    
    func test_isArticleExists_whenNotExists() {
        // Given
        let articleId = "nonExistentArticle"
        
        // When
        let isExists = sut.isArticleExists(articleId)
        
        // Then
        XCTAssertFalse(isExists)
    }
}

