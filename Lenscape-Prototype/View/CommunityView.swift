//
//  CommunityView.swift
//  Lenscape-Prototype
//

import SwiftUI

struct CommunityView: View {
    @State private var viewModel = QuestsCompletedViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    if viewModel.communityPosts.isEmpty {
                        ContentUnavailableView(
                            "No Posts Yet",
                            systemImage: "bubble.left.and.bubble.right",
                            description: Text("Complete a quest item to share your experience with the community.")
                        )
                    } else {
                        ForEach(viewModel.communityPosts) { post in
                            VStack(alignment: .leading, spacing: 8) {
                                Text(post.questTitle)
                                    .font(.headline)
                                    .foregroundStyle(.blue)
                                
                                Text(post.userReflection)
                                    .font(.body)
                                
                                Text(post.dateSubmitted.formatted(date: .abbreviated, time: .shortened))
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(16)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Community Feed")
        }
    }
}
