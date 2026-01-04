//
//  CharacterRepository.swift
//  VIPER
//
//  Created by rico on 4.01.2026.
//

import Foundation

final class CharacterRepository: ICharacterRepository {
    private let client: NetworkClientProtocol
    
    init(client: NetworkClientProtocol) {
        self.client = client
    }
    
    func fetchCharacters() async throws -> [RMCharacterResponse] {
        let endpoint = RickAndMortyAPI.getCharacters()
        let response = try await client.request(endpoint)
        return response.results
    }
}
