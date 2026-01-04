//
//  CharacterRepositoryProtocol.swift
//  VIPER
//
//  Created by rico on 4.01.2026.
//

import Foundation

protocol CharacterRepositoryProtocol {
    func fetchCharacters() async throws -> [RMCharacterResponse]
    func fetchCharacterDetail(id: Int) async throws -> RMCharacterResponse
}
