//
//  FetchCharactersUseCase.swift
//  VIPER
//
//  Created by rico on 3.01.2026.
//

import Foundation

protocol FetchCharactersUseCaseProtocol {
    func execute() async -> [RMCharacterResponse]
}

final class MockFetchCharactersUseCase: FetchCharactersUseCaseProtocol {
    func execute() async -> [RMCharacterResponse] {
        try? await Task.sleep(nanoseconds: 1 * 1_000_000_000)
        
        return [
            RMCharacterResponse(id: 1, name: "Rick Sanchez", status: "Alive", image: ""),
            RMCharacterResponse(id: 2, name: "Morty Smith", status: "Alive", image: ""),
            RMCharacterResponse(id: 3, name: "Summer Smith", status: "Alive", image: "")
        ]
    }
}
