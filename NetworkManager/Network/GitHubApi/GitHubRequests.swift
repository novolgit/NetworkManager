//
//  GitHubRequests.swift
//  NetworkManager
//
//  Created by Влад Новолоакэ on 20/11/24.
//

import Foundation

enum GitHubRequests {
    case usersList
    case user(username: String)
}

extension GitHubRequests: Endpoint {
    var host: String {
        "api.github.com"
    }
    
    var path: String {
        switch self {
        case .usersList:
            "/users"
        case .user(let username):
            "/users/\(username)"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .user, .usersList:
                .get
        }
    }
    
    var header: [String : String]? {
        switch self {
        case .user, .usersList:
            
            // MARK: provide token here from your GitHub account
            let token = ""
            
            let header = [
                "Accept": "application/vnd.github+json",
//                "Content-Type": "application/json;charset=utf-8"
                "Authorization": "Bearer \(token)",
                "X-GitHub-Api-Version": "2022-11-28"
            ]
            
            return header
        }
    }
    
    var body: [String : String]? {
        switch self {
        case .user, .usersList:
                nil
        }
    }
}
