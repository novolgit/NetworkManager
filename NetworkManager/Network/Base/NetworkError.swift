//
//  NetworkError.swift
//  NetworkManager
//
//  Created by Влад Новолоакэ on 20/11/24.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case emptyResponse
    case notFound
    case unathorized
    case serverError
    case notDecoded
    
    case unexpected
    case unknown
}
