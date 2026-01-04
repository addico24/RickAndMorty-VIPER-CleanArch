//
//  HomeRouter.swift
//  VIPER
//
//  Created by rico on 4.01.2026.
//

import UIKit

@MainActor
final class HomeRouter: HomeRouterProtocol {
    private weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func navigateToDetail(with character: RMCharacterResponse) {
        let detailVC = DetailFactory.create(withId: character.id)
        viewController?.navigationController?.pushViewController(detailVC, animated: true)
    }
}
