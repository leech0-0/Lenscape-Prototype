//
//  QuestsView.swift
//  Lenscape-Prototype
//

import SwiftUI

struct QuestsView: View {
    
    @Environment(QuestsCompletedViewModel.self)
    private var viewModel
    
    @Environment(CommunityViewModel.self)
    private var communityViewModel
    
    @Environment(\.colorScheme) private var colorScheme
    
    @State private var selectedTaskForInput: QuestItem? = nil
    
    var body: some View {
        NavigationStack{
            // MARK: - Background Gradient
            ZStack(alignment: .top) {
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.blue.opacity(0.8),
                        Color.blue.opacity(0.5),
                        colorScheme == .dark
                        ? Color.gray.opacity(0.3)
                        : Color.white.opacity(0.3),
                        colorScheme == .dark
                        ? Color.gray.opacity(0.5)
                        : Color.white.opacity(0.5)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                
            ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        
                        // MARK: - Title Card
                        HStack(alignment: .top) {
                            VStack(alignment: .leading, spacing: 12) {
                                Text("Community Connection Quests")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                
                                Button {
                                    // Expand/details logic
                                } label: {
                                    HStack(spacing: 4) {
                                        Text("See details")
                                        Image(systemName: "chevron.right")
                                    }
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.blue)
                                }
                            }
                            
                            Spacer()
                            
                            Image(viewModel.communityBadgeImage)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .animation(.easeInOut(duration: 0.3), value: viewModel.completedReflectionCount)
                        }
                        .padding(20)
                        .background(Color.blue.opacity(0.15))
                        .cornerRadius(20)
                        .padding(.horizontal)
                        
                        // MARK: - Quests Section
                        Text("Quests")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.horizontal)
                        
                        VStack(spacing: 12) {
                            ForEach(viewModel.questTasks) { task in
                                QuestTaskRow(task: task) {
                                    
                                    // do NOT complete the task here
                                    // Completion happens after the reflection is submitted
                                    
                                    selectedTaskForInput = task
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    .padding(.vertical)
                }
                .sheet(item: $selectedTaskForInput) { task in
                    QuestInputView(
                        viewModel: viewModel,
                        communityViewModel: communityViewModel,
                        task: task)
                }
                .onAppear {
                    viewModel.markVideoAsWatched()
                }
            }
        }
    }
}

// MARK: - Subview for Individual Quest Card
struct QuestTaskRow: View {
    let task: QuestItem
    let onTap: () -> Void
    
    var body: some View {
        HStack(alignment: .top, spacing: 14) {
            
            // Checkbox / Completion Icon
            Button(action: onTap) {
                Image(systemName: task.isCompleted ? "checkmark.square.fill" : "square")
                    .resizable()
                    .frame(width: 28, height: 28)
                    .foregroundStyle(task.isCompleted ? .blue : .gray)
            }
            .buttonStyle(.plain)
            
            // Task Description Content
            VStack(alignment: .leading, spacing: 6) {
                Text(task.title)
                    .font(.headline)
                    .fontWeight(.bold)
                
                if task.isCompleted {
                    Text("Task Completed!")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                } else {
                    Text(task.description)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
            
            Spacer()
            
            // Edit icon when completed
            if task.isCompleted {
                Button(action: onTap) {
                    Image(systemName: "pencil.circle")
                        .resizable()
                        .frame(width: 26, height: 26)
                        .foregroundStyle(.blue)
                }
            }
        }
        .padding(16)
        .background(Color("homePageCard"))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}

#Preview {
 QuestsView()
}

