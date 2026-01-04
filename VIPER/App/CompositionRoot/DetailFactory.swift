//
//  DetailFactory.swift
//  VIPER
//
//  Created by rico on 4.01.2026.
//

import Foundation
import UIKit

@MainActor
final class DetailFactory {
    
    static func create(withId id: Int) -> UIViewController {
        let view = DetailViewController()
        
        let client = AlamofireNetworkClient()
        let repository = RemoteCharacterRepository(client: client)
        let useCase = FetchCharacterDetailUseCase(repository: repository)
        
        let presenter = DetailPresenter(view: view, useCase: useCase, characterId: id)
        
        view.presenter = presenter
        return view
    }
}
