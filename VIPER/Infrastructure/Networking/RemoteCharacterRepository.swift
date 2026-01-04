//
//  RemoteCharacterRepository.swift
//  VIPER
//
//  Created by rico on 4.01.2026.
//

import Foundation

final class RemoteCharacterRepository: CharacterRepositoryProtocol {
    private let client: NetworkClientProtocol
    
    init(client: NetworkClientProtocol) {
        self.client = client
    }
    
    func fetchCharacters() async throws -> [RMCharacterResponse] {
        let endpoint = RickAndMortyAPI.getCharacters()
        let response = try await client.request(endpoint)
        return response.results
    }
    
    func fetchCharacterDetail(id: Int) async throws -> RMCharacterResponse {
        let endpoint = RickAndMortyAPI.getCharacterDetail(id: id)
        return try await client.request(endpoint)
    }
}
