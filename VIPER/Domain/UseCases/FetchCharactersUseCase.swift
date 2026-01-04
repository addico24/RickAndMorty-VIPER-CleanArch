//
//  FetchCharactersUseCase.swift
//  VIPER
//
//  Created by rico on 3.01.2026.
//

import Foundation

protocol FetchCharactersUseCaseProtocol {
    func execute() async throws -> [RMCharacterResponse]
}

final class FetchCharactersUseCase: FetchCharactersUseCaseProtocol {
    private let repository: CharacterRepositoryProtocol
    
    init(repository: CharacterRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() async throws -> [RMCharacterResponse] {
        return try await repository.fetchCharacters()
    }
}
