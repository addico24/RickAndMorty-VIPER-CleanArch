//
//  RMResultsResponse.swift
//  VIPER
//
//  Created by rico on 4.01.2026.
//

import Foundation

struct RMResultsResponse: Decodable {
    let results: [RMCharacterResponse]
}

struct RMCharacterResponse: Decodable {
    let id: Int
    let name: String?
    let status: String?
    let image: String?
}
