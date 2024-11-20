//
//  UsersViewModel.swift
//  NetworkManager
//
//  Created by Влад Новолоакэ on 20/11/24.
//

import Foundation

extension UsersView {
    
    @Observable
    class ViewModel {
        let githubService: GitHubService
        
        var users = [GitHubUser]()
        var pageState: PageState = .none
        
        init(githubService: GitHubService) {
            self.githubService = githubService
        }
        
        func getUsers() async {
            if users.isEmpty {
                pageState = .loading
            }
            
            users = await githubService.getUsersList()
            
            if users.isEmpty {
                pageState = .empty
            } else {
                pageState = .loaded
            }
        }
        
        func getUser(_ username: String) async -> GitHubUser? {
            return await githubService.getUser(username: username)
        }
    }
}
