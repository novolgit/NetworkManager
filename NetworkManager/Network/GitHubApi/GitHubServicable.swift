//
//  GitHubServicable.swift
//  NetworkManager
//
//  Created by Влад Новолоакэ on 20/11/24.
//

import Foundation

protocol GitHubServicable {
    func getUsersList() async -> [GitHubUser]
    func getUser(username: String) async -> GitHubUser?
}
