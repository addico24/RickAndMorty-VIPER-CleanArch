//
//  FetchCharactersUseCase.swift
//  VIPER
//
//  Created by rico on 3.01.2026.
//

import Foundation

protocol FetchCharactersUseCaseProtocol {
    func execute() async -> [RMCharacter]
}

final class MockFetchCharactersUseCase: FetchCharactersUseCaseProtocol {
    func execute() async -> [RMCharacter] {
        try? await Task.sleep(nanoseconds: 1 * 1_000_000_000)
        
        return [
            RMCharacter(id: 1, name: "Rick Sanchez", status: "Alive", image: ""),
            RMCharacter(id: 2, name: "Morty Smith", status: "Alive", image: ""),
            RMCharacter(id: 3, name: "Summer Smith", status: "Alive", image: "")
        ]
    }
}
