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
        let useCase = MockFetchCharactersUseCase()
        let presenter = HomePresenter(view: view,
                                      useCase: useCase,
                                      router: router)
        view.presenter = presenter
        
        return view
    }
}
