//
//  NetworkClientProtocol.swift
//  VIPER
//
//  Created by rico on 4.01.2026.
//

import Foundation

protocol NetworkClientProtocol {
    func request<R: Decodable>(_ endpoint: Endpoint<R>) async throws -> R
}
