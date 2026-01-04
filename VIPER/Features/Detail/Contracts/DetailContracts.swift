//
//  DetailContracts.swift
//  VIPER
//
//  Created by rico on 4.01.2026.
//

import Foundation

@MainActor
protocol DetailViewProtocol: AnyObject {
    func showLoading()
    func hideLoading()
    func updateView(with data: DetailViewData)
    func showError(_ message: String)
}

@MainActor
protocol DetailPresenterProtocol {
    func viewDidLoad()
}

protocol FetchCharacterDetailUseCaseProtocol {
    func execute(id: Int) async throws -> RMCharacterResponse
}
