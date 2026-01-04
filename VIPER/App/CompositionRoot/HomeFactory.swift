//
//  HomeFactory.swift
//  VIPER
//
//  Created by rico on 4.01.2026.
//

import UIKit

@MainActor
final class HomeFactory {
    
    static func create() -> UIViewController {
        let view = HomeViewController()
        let router = HomeRouter(viewController: view)
        let networkClient = AlamofireNetworkClient()
        let repository = CharacterRepository(client: networkClient)
        let useCase = FetchCharactersUseCase(repository: repository)
        let presenter = HomePresenter(view: view,
                                      useCase: useCase,
                                      router: router)
        view.presenter = presenter
        return view
    }
}
