//
//  ICharacterRepository.swift
//  VIPER
//
//  Created by rico on 4.01.2026.
//

import Foundation

protocol ICharacterRepository {
    func fetchCharacters() async throws -> [RMCharacterResponse]
}
