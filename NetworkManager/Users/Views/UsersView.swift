//
//  UsersView.swift
//  NetworkManager
//
//  Created by Влад Новолоакэ on 20/11/24.
//

import SwiftUI

struct UsersView: View {
    @State private var viewModel: ViewModel
    
    init() {
        self.viewModel = ViewModel(githubService: GitHubService())
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                switch viewModel.pageState {
                case .loading:
                    ProgressView()
                case .loaded:
                    List(viewModel.users) { user in
                        NavigationLink(value: Route.userDetails(user)) {
                            userView(user)
                                .alignmentGuide(.listRowSeparatorLeading) {_ in
                                    return 0
                                }
                        }
                    }
                case .empty:
                    emptyView
                case .none:
                    initView
                }
            }
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .userDetails(let user):
                    UserDetails(viewModel: viewModel, user: user)
                }
            }
            .task {
                // it will be fired each time after returning
                await viewModel.getUsers()
            }
            .navigationTitle("GitHub users")
        }
    }
    
    @ViewBuilder
    private func userView(_ user: GitHubUser) -> some View {
        HStack(spacing: 10) {
            AsyncImage(url: URL(string: user.avatarUrl)) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .clipShape(.circle)
            } placeholder: {
                Circle()
                    .fill(.gray)
            }
            .frame(width: 30, height: 30)
            Text(user.login)
        }
    }
    
    private var emptyView: some View {
        ContentUnavailableView {
            Text("Users not found")
        } description: {
            Text("Tap button to fetch again")
        } actions: {
            Button("Fetch users") {
                Task {
                    await viewModel.getUsers()
                }
            }
        }
    }
    
    private var initView: some View {
        Text("This is init view, preview can be provided")
    }
}

#Preview {
    UsersView()
}
