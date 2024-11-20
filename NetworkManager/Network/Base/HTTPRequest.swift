//
//  HTTPRequest.swift
//  NetworkManager
//
//  Created by Влад Новолоакэ on 20/11/24.
//

import Foundation

protocol HTTPRequest {
    func sendRequest<T: Codable>(endpoint: Endpoint, model: T.Type) async -> T?
}

extension HTTPRequest {
    func sendRequest<T: Codable>(endpoint: Endpoint, model: T.Type) async -> T? {
        do {
            return try await request(endpoint: endpoint, model: model)
        }
        catch NetworkError.invalidURL { print("url is invalid") }
        catch NetworkError.emptyResponse { print("response is empty") }
        catch NetworkError.notFound { print("not found 404") }
        catch NetworkError.unathorized { print("unathorized 401") }
        catch NetworkError.serverError { print("server error 500") }
        catch NetworkError.notDecoded { print("can't decode \(model)") }
        catch NetworkError.unexpected { print("unexpected error") }
        catch NetworkError.unknown { print("unknown error") }
        catch { print("unexpected error \(error.localizedDescription)") }
        
        return nil
    }
    
    private func request<T: Codable>(endpoint: Endpoint, model: T.Type) async throws -> T {
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        
        guard let url = urlComponents.url else {
            throw NetworkError.invalidURL
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method.rawValue
        urlRequest.allHTTPHeaderFields = endpoint.header
        
        if let body = endpoint.body {
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: body)
        }
        
        guard let (data, response) = try? await URLSession.shared.data(for: urlRequest) else { throw NetworkError.unknown }
        
        guard let response = response as? HTTPURLResponse else { throw NetworkError.emptyResponse }
        
        switch response.statusCode {
        case 200...299:
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
//            print(String(decoding: data, as: UTF8.self))
            
            guard let decodedData = try? decoder.decode(model, from: data)
            else { throw NetworkError.notDecoded }
            
            return decodedData
        case 401:
            throw NetworkError.unathorized
        case 404:
            throw NetworkError.notFound
        case 500...:
            throw NetworkError.serverError
         default:
            throw NetworkError.unexpected
        }
    }
}
