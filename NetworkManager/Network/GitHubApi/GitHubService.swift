//
//  GitHubService.swift
//  NetworkManager
//
//  Created by Влад Новолоакэ on 20/11/24.
//

import Foundation

struct GitHubService: GitHubServicable, HTTPRequest {
    func getUsersList() async -> [GitHubUser] {
        let request: [GitHubUser]? = await sendRequest(endpoint: GitHubRequests.usersList, model: [GitHubUser].self)
        return request ?? []
    }
    
    func getUser(username: String) async -> GitHubUser? {
        return await sendRequest(endpoint: GitHubRequests.user(username: username), model: GitHubUser.self)
    }
}


