//
//  HomePresenter.swift
//  VIPER
//
//  Created by rico on 3.01.2026.
//

import Foundation

@MainActor
final class HomePresenter: HomePresenterProtocol {
    
    private weak var view: HomeViewProtocol?
    private let useCase: FetchCharactersUseCaseProtocol
    private let router: HomeRouterProtocol
    
    init(view: HomeViewProtocol, useCase: FetchCharactersUseCaseProtocol, router: HomeRouterProtocol) {
        self.view = view
        self.useCase = useCase
        self.router = router
    }
    
    func viewDidLoad() {
        fetchCharacters()
    }
    
    func didSelect(character: RMCharacter) {
        router.navigateToDetail(with: character)
    }
}

// MARK: -
extension HomePresenter {
    private func fetchCharacters() {
        view?.showLoading()
        
        Task {
            let characters = await useCase.execute()
            view?.hideLoading()
            view?.updateView(with: characters)
        }
    }
}
