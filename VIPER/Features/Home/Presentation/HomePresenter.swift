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
    private let useCase: IFetchCharactersUseCase
    private let router: HomeRouterProtocol
    
    private var domainCharacters: [RMCharacterResponse] = []
    
    init(view: HomeViewProtocol, useCase: IFetchCharactersUseCase, router: HomeRouterProtocol) {
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
        
        print("Selected: \(selectedCharacter.name ?? "")")
        router.navigateToDetail(with: selectedCharacter)
    }
}

// MARK: -
extension HomePresenter {
    private func fetchCharacters() {
        view?.showLoading()
        
        Task {
            do {
                let characters = try await useCase.execute()
                self.domainCharacters = characters
                
                let viewItems = characters.map { characterItem in
                    return CharacterViewItem(
                        name: characterItem.name ?? "-",
                        statusText: "Status: \(characterItem.status ?? "")",
                        statusColor: characterItem.status == "Alive" ? .systemGreen : .systemRed,
                        image: URL(string: characterItem.image ?? "") ?? URL(fileURLWithPath: "")
                    )
                }
                view?.updateView(with: viewItems)
                
            } catch {
                view?.showError(error.localizedDescription)
            }
            view?.hideLoading()
        }
    }
}
