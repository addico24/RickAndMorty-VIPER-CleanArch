//
//  AlamofireNetworkClient.swift
//  VIPER
//
//  Created by rico on 4.01.2026.
//

import Alamofire
import Foundation

final class AlamofireNetworkClient: NetworkClientProtocol {
    private let baseURL: String
    
    init(baseURL: String = "https://rickandmortyapi.com/api/") {
        self.baseURL = baseURL
    }
    
    func request<R: Decodable>(_ endpoint: Endpoint<R>) async throws -> R {
        let url = baseURL + endpoint.path
        
        let afMethod = Alamofire.HTTPMethod(rawValue: endpoint.method.rawValue)
        let encoding: ParameterEncoding
        
        if endpoint.method == .get {
            encoding = URLEncoding.default
        } else {
            encoding = JSONEncoding.default
        }
        
        let afHeaders = (endpoint.headers != nil) ? HTTPHeaders(endpoint.headers!) : nil
        
        let request = AF.request(
            url,
            method: afMethod,
            parameters: endpoint.parameters,
            encoding: encoding,
            headers: afHeaders
        )
            .validate()
            .serializingDecodable(R.self)
        
        let response = await request.response
        
        switch response.result {
        case .success(let data):
            return data
        case .failure(let afError):
            throw mapError(afError, response: response.response)
        }
    }
    
    private func mapError(_ error: AFError, response: HTTPURLResponse?) -> NetworkError {
        if let code = response?.statusCode {
            return .serverError(statusCode: code)
        }
        
        switch error {
        case .responseSerializationFailed:
            return .decodingError
        default:
            return .unknown(error)
        }
    }
}
