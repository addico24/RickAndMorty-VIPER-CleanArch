//
//  NetworkError.swift
//  VIPER
//
//  Created by rico on 4.01.2026.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case decodingError
    case serverError(statusCode: Int)
    case unknown(Error)
    
    var localizedDescription: String {
        switch self {
        case .invalidURL: return "Geçersiz URL"
        case .decodingError: return "Veri modeli parse edilemedi"
        case .serverError(let code): return "Sunucu Hatası: \(code)"
        case .unknown(let error): return error.localizedDescription
        }
    }
}
