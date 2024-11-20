//
//  UserDetails.swift
//  NetworkManager
//
//  Created by Влад Новолоакэ on 20/11/24.
//

import SwiftUI

struct UserDetails: View {
    var viewModel: UsersView.ViewModel
    
    @State private var user: GitHubUser
    
    // inject ViewModel and reusing already fetched user's data for sake of seamless
    init(viewModel: UsersView.ViewModel, user: GitHubUser) {
        self.viewModel = viewModel
        self._user = State(initialValue: user)
    }
    
    var body: some View {
        VStack(spacing: 20) {
            ScrollView {
                AsyncImage(url: URL(string: user.avatarUrl)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .clipShape(.circle)
                } placeholder: {
                    Circle()
                        .fill(.gray)
                }
                .frame(width: 150, height: 150)
                
                Divider()
                
                if let name = user.name {
                    Text("\(name)")
                }
                
                if let bio = user.bio {
                    Text("Bio: \(bio)")
                }
                
                HStack {
                    if let followers = user.followers {
                        Text("followers: \(followers)")
                    } else {
                        Text("followers: 100000")
                            .foregroundStyle(.clear)
                    }
                    Spacer()
                    if let following = user.following {
                        Text("following: \(following)")
                    } else {
                        Text("following: 100000")
                            .foregroundStyle(.clear)
                    }
                }
            }
        }
        .padding()
        .task {
            if let user = await viewModel.getUser(user.login) {
                self.user = user
            }
        }
        .navigationTitle(user.login)
        .navigationBarTitleDisplayMode(.inline)
    }
}
