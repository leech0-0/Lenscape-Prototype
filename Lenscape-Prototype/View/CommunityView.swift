//
//  CommunityView.swift
//  Lenscape-Prototype
//

import SwiftUI
import SwiftData

struct CommunityView: View {
    
    @Environment(QuestsCompletedViewModel.self)
    private var questsViewModel
    
    @Environment(CommunityViewModel.self)
    private var viewModel
    
    @Query private var communityPosts: [CommunityPost]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20){
                    
                    //MARK: - Header
                    
                    Text("Community")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    //MARK: - Theme
                    Text("Theme selected")
                        .font(.title3)
                        .fontWeight(.bold)
                    
                    
                    Text("Environmentalism Week")
                        .font(.title3)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(Color.white, in: Capsule() )
                        .overlay {
                            Capsule()
                                .stroke(
                                    Color.green, lineWidth: 1
                                )
                        }
                    
                    //MARK: - Quest Selection
                    HStack(spacing: 10) {
                        ForEach(Array(questsViewModel.questTasks.enumerated()), id: \.element.id) { index, task in
                            QuestButton(
                                index: index,
                                isSelected: viewModel.selectedTaskID == task.id
                            ) {
                                viewModel.selectedTaskID = task.id
                            }
                        }
                    }
                    
                    //MARK: - Community Posts
                    if let selectedTaskID = viewModel.selectedTaskID {
                        
                        let posts = communityPosts.filter{
                            $0.taskID == selectedTaskID
                        }
                        
                        if posts.isEmpty {
                            
                            CommunityLockedView()
                            
                        } else {
                            VStack(spacing: 14) {
                                
                                ForEach(posts) { post in
                                
                                CommunityPostCard(post: post)
                                }
                            }
                        }
                    } else {
                        
                        CommunityLockedView()
                    }
                }
                .padding()
            }
            .background(
                Color.green.opacity(0.08)
                    .ignoresSafeArea()
            )
            
            .navigationBarTitleDisplayMode(.inline)
            
            .onAppear {
                
                //select first quest automatically
                if viewModel.selectedTaskID == nil,
                   let firstTask = questsViewModel.questTasks.first {
                    
                    viewModel.selectedTaskID = firstTask.id
                }
            }
        }
    }
}

//MARK: - QuestButton trial
struct QuestButton: View {
    let index: Int
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text("Quest \(index + 1)")
                .font(.headline)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(
                    isSelected
                    ? Color.green.opacity(0.7)
                    : Color.green.opacity(0.25),
                    in: RoundedRectangle(cornerRadius: 16)
                )
        }
        .buttonStyle(.plain)
    }
}

// MARK: - CommunityLockedView

struct CommunityLockedView: View {
    var body: some View {
        
        VStack(spacing: 14){
            
            Image(systemName: "lock.fill")
                .font(.system(size: 32))
                .foregroundStyle(.secondary)
            
            
            Text("Community Locked")
                .font(.headline)
            
            Text("Complete this quest and submit your reflection to see how others approached it.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(30)
        .background(Color.white, in: RoundedRectangle(cornerRadius: 20))
        
    }
}
    
    //MARK: - CommunityPostCard
    
    struct CommunityPostCard: View {
        let post: CommunityPost
        
        var body: some View {
            HStack(alignment: .top, spacing: 14) {
                
                VStack(alignment: .leading, spacing: 6) {
                    Text(post.questTitle)
                        .font(.headline)
                        .fontWeight(.bold)
                    
                    Text("Quest @user")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    
                    Text(post.userReflection)
                        .font(.subheadline)
                        .lineLimit(4)
                    
                    
                    Text(post.dateSubmitted.formatted(
                        date: .abbreviated,
                        time: .omitted
                    ))
                    .font(.caption)
                    .foregroundStyle(.secondary)
                }
                
                Spacer()
            }
            .padding(12)
            .background(Color.white, in: RoundedRectangle(cornerRadius: 18))
            .overlay {
                RoundedRectangle(cornerRadius: 18)
                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
            }
        }
    }
