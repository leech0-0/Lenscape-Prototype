//
//  CommunityView.swift
//  Lenscape-Prototype
//

import SwiftUI
import SwiftData
import UIKit

struct CommunityView: View {
    
    @Environment(QuestsCompletedViewModel.self)
    private var questsViewModel
    
    @Environment(CommunityViewModel.self)
    private var viewModel
    
    @Query private var communityPosts: [CommunityPost]
    
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        NavigationStack {
            
            // MARK: - Background Gradient
            ZStack(alignment: .top) {
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color("commBackground").opacity(0.8),
                        Color("commBackground").opacity(0.5),
                        colorScheme == .dark
                        ? Color.green.opacity(0.3)
                        : Color.white.opacity(0.3),
                        colorScheme == .dark
                        ? Color.green.opacity(0.1)
                        : Color.white.opacity(0.5)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                ZStack{
                    Image(colorScheme == .dark ? "communityDM" : "communityLM")
                        .resizable()
                        .frame(width: 175, height: 130)
                        .offset(x: 95)
                }
                
                ScrollView {
                    
                    VStack(alignment: .leading, spacing: 20){
                        //MARK: - Header
                        Text("Community")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        //MARK: - Theme
                        Text("Theme selected")
                            .font(.title3)
                            .fontWeight(.bold)
                        
                        
                        Text("Environmentalism Week")
                            .font(.title3)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                            .background(Color("homePageCard"), in: Capsule() )
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
                        
                        // MARK: - Community Posts
                        if let selectedTaskID = viewModel.selectedTaskID,
                           let questIndex = questsViewModel.questTasks.firstIndex(
                            where: { $0.id == selectedTaskID }
                           ) {
                            
                            let posts = communityPosts.filter {
                                $0.taskID == selectedTaskID
                            }
                            
                            if posts.isEmpty {
                                
                                // No user reflection submitted for this quest yet
                                CommunityLockedView()
                                
                            } else {
                                
                                VStack(spacing: 14) {
                                    
                                    // MARK: - User's Submitted Reflection
                                    ForEach(posts) { post in
                                        CommunityPostCard(post: post)
                                    }
                                    
                                    // MARK: - Four Example Reflections
                                    ForEach(viewModel.examples(for: questIndex)) { example in
                                        CommunityExamplePostCard(reflection: example)
                                    }
                                }
                            }
                            
                        } else {
                            CommunityLockedView()
                        }
                    }
                }
            }
        }
    }
}


// MARK: - Example Community Post Card
struct CommunityExamplePostCard: View {
    let reflection: CommunityExampleReflection

    var body: some View {
        HStack(alignment: .top, spacing: 12) {

            // Example reflection photo
            Image(reflection.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 110, height: 110)
                .clipShape(
                    RoundedRectangle(cornerRadius: 12)
                )

            // Example reflection text
            VStack(alignment: .leading, spacing: 8) {
                Text("Community Reflection")
                    .font(.headline)

                Text(reflection.text)
                    .font(.body)
                    .fixedSize(
                        horizontal: false,
                        vertical: true
                    )
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            Color("homePageCard"),
            in: RoundedRectangle(cornerRadius: 16)
        )
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
            .background(Color("homePageCard"), in: RoundedRectangle(cornerRadius: 20))
            
        }
    }
    
    //MARK: - CommunityPostCard
    
    struct CommunityPostCard: View {
        let post: CommunityPost
        
        var body: some View {
            HStack(alignment: .top, spacing: 12) {
                
                // Reflection photo
                if let imageData = post.imageData,
                   let uiImage = UIImage(data: imageData) {
                    
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 110, height: 110)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 12)
                        )
                }
                
                // Reflection text
                VStack(alignment: .leading, spacing: 8) {
                    Text(post.questTitle)
                        .font(.headline)
                    
                    Text(post.userReflection)
                        .font(.body)
                        .fixedSize(
                            horizontal: false,
                            vertical: true
                        )
                    
                    Text(post.dateSubmitted, style: .date)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                Color("homePageCard"),
                in: RoundedRectangle(cornerRadius: 16)
            )
        }
    }

#Preview {
    CommunityView()
        .environment(QuestsCompletedViewModel())
        .environment(CommunityViewModel())
        .modelContainer(for: CommunityPost.self)
}
