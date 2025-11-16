//
//  BaseViewModel.swift
//  BoynerNews
//
//  Created by Yaman Boztepe on 11.11.2025.
//

import Combine

class BaseViewModel: ObservableObject {
    // MARK: - Published (UI bindable)
    @Published private(set) var isLoading = false
    @Published var alert: AlertModel?
    @Published var presentEmptyState = false
    @Published var screenTitle = ""
    
    // MARK: - Dependencies
    var service: NetworkServiceProtocol
    var articlesRepository: ArticlesRepositoryProtocol
    var pollingService: PollingServiceProtocol
    
    init(service: NetworkServiceProtocol = NetworkFactory.makeNetworkManager(),
         articlesRepository: ArticlesRepositoryProtocol = ArticlesRepository(),
         pollingService: PollingServiceProtocol = PollingService()) {
        self.service = service
        self.articlesRepository = articlesRepository
        self.pollingService = pollingService
    }
    
    // MARK: - Core Logics
    
    func callService<T: Decodable>(_ request: BNServiceRequest, responseType: T.Type) async -> T? {
        isLoading = true
        defer { isLoading = false }
        
        let result = await service.callService(request, responseType: responseType)
        
        switch result {
        case .success(let success):
            return success
        case .failure(let failure):
            let dismissButton = AlertButton(title: "Dismiss") { [weak self] in
                self?.alert = nil
            }
            alert = AlertModel(title: failure.localizedDescription, buttons: [dismissButton])
        }
        
        return nil
    }
}
