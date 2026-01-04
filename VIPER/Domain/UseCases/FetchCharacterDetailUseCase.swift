//
//  FetchCharacterDetailUseCase.swift
//  VIPER
//
//  Created by rico on 4.01.2026.
//

import Foundation

final class FetchCharacterDetailUseCase: FetchCharacterDetailUseCaseProtocol {
    private let repository: CharacterRepositoryProtocol
    
    init(repository: CharacterRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(id: Int) async throws -> RMCharacterResponse {
        return try await repository.fetchCharacterDetail(id: id)
    }
}
