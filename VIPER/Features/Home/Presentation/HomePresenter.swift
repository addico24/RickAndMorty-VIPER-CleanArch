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
    
    private var domainCharacters: [RMCharacter] = []
    
    init(view: HomeViewProtocol, useCase: FetchCharactersUseCaseProtocol, router: HomeRouterProtocol) {
        self.view = view
        self.useCase = useCase
        self.router = router
    }
    
    func viewDidLoad() {
        fetchCharacters()
    }
    
    func didSelect(at index: Int) {
        guard domainCharacters.indices.contains(index) else { return }
        let selectedCharacter = domainCharacters[index]
        router.navigateToDetail(with: selectedCharacter)
    }
}

// MARK: -
extension HomePresenter {
    private func fetchCharacters() {
        view?.showLoading()
        
        Task {
            let characters = await useCase.execute()
            self.domainCharacters = characters
            
            let viewItems = characters.map { characterItem in
                return CharacterViewItem(
                    name: characterItem.name ?? "-",
                    statusText: "Status: \(characterItem.status ?? "")",
                    statusColor: characterItem.status == "Alive" ? .systemGreen : .systemRed,
                    image: URL(string: characterItem.image ?? "") ?? URL(fileURLWithPath: "")
                )
            }
            
            view?.hideLoading()
            view?.updateView(with: viewItems)
        }
    }
}
