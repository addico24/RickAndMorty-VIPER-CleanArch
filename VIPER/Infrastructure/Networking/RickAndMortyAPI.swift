//
//  RickAndMortyAPI.swift
//  VIPER
//
//  Created by rico on 4.01.2026.
//

import Foundation

enum RickAndMortyAPI {
    static func getCharacters() -> Endpoint<RMResultsResponse> {
        return Endpoint(
            path: "character",
            method: .get
        )
    }
}
