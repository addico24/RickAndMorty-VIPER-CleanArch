//
//  HomeContracts.swift
//  VIPER
//
//  Created by rico on 3.01.2026.
//

import Foundation

@MainActor
protocol HomeViewProtocol: AnyObject {
    func showLoading()
    func hideLoading()
    func updateView(with characterItems: [CharacterViewItem])
    func showError(_ message: String)
}

@MainActor
protocol HomePresenterProtocol {
    func viewDidLoad()
    func didSelect(at index: Int)
}

@MainActor
protocol HomeRouterProtocol {
    func navigateToDetail(with character: RMCharacter)
}
