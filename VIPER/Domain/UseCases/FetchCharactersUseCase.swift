//
//  FetchCharactersUseCase.swift
//  VIPER
//
//  Created by rico on 3.01.2026.
//

import Foundation

protocol IFetchCharactersUseCase {
    func execute() async throws -> [RMCharacterResponse]
}

final class FetchCharactersUseCase: IFetchCharactersUseCase {
    private let repository: CharacterRepository
    
    init(repository: CharacterRepository) {
        self.repository = repository
    }
    
    func execute() async throws -> [RMCharacterResponse] {
        return try await repository.fetchCharacters()
    }
}
