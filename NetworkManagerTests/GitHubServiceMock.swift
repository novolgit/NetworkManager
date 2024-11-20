//
//  GitHubServiceMock.swift
//  NetworkManager
//
//  Created by Влад Новолоакэ on 20/11/24.
//

import Foundation

struct GitHubServiceMock: Testable, GitHubServicable {
    func getUsersList() async -> [GitHubUser] {
        loadMockJson(filename: "users", model: [GitHubUser].self)
    }
    
    func getUser(username: String) async -> GitHubUser? {
        loadMockJson(filename: "user", model: GitHubUser.self)
    }
}
