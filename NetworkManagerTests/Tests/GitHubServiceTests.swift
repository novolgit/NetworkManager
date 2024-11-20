//
//  GitHubServiceTests.swift
//  NetworkManager
//
//  Created by Влад Новолоакэ on 20/11/24.
//

import XCTest

@testable import NetworkManager

final class GitHubServiceTests: XCTestCase {

    func testFetchUsers() throws {
        let githubService = GitHubServiceMock()
        
        let users = githubService.loadMockJson(filename: "users", model: [GitHubUser].self)
        
        XCTAssert(users.count > 0)
        XCTAssertEqual(users.count, 0)
        XCTAssertEqual(users[0].login, "octocat")
    }

    func testFetchUser() throws {
        let id: Int = 1
        let githubService = GitHubServiceMock()
        
        let user = githubService.loadMockJson(filename: "user", model: GitHubUser.self)
        
        XCTAssertEqual(user.login, "octocat")
        XCTAssertEqual(user.id, 1)
    }
}
