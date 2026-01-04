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
    let species: String?
    let gender: String?
    let image: String?
    let origin: RMOrigin?
    let location: RMLocation?
}

struct RMOrigin: Decodable {
    let name: String?
    let url: String?
}

struct RMLocation: Decodable {
    let name: String?
    let url: String?
}
