//
//  DetailPresenter.swift
//  VIPER
//
//  Created by rico on 4.01.2026.
//

import UIKit

@MainActor
final class DetailPresenter: DetailPresenterProtocol {
    
    private weak var view: DetailViewProtocol?
    private let useCase: FetchCharacterDetailUseCaseProtocol
    private let characterId: Int
    
    init(view: DetailViewProtocol, useCase: FetchCharacterDetailUseCaseProtocol, characterId: Int) {
        self.view = view
        self.useCase = useCase
        self.characterId = characterId
    }
    
    func viewDidLoad() {
        fetchDetail()
    }
    
    private func fetchDetail() {
        view?.showLoading()
        
        Task {
            do {
                let response = try await useCase.execute(id: characterId)
                let viewData = prepareViewData(from: response)
                view?.updateView(with: viewData)
            } catch {
                view?.showError(error.localizedDescription)
            }
            view?.hideLoading()
        }
    }
    
    private func prepareViewData(from response: RMCharacterResponse) -> DetailViewData {
        let status = response.status ?? "-"
        let species = response.species ?? "-"
        
        return DetailViewData(
            title: response.name ?? "-",
            imageURL: URL(string: response.image ?? ""),
            statusText: "\(status) ~ \(species)",
            statusColor: status == "Alive" ? .systemGreen : (status == "Dead" ? .systemRed : .systemGray),
            genderText: "Gender: \(response.gender ?? "-")",
            originText: "Origin: \(response.origin?.name ?? "-")",
            locationText: "Location: \(response.location?.name ?? "-")"
        )
    }
}
