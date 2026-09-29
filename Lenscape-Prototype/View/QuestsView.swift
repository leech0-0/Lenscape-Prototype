//
//  QuestsView.swift
//  Lenscape-Prototype
//

import SwiftUI

struct QuestsView: View {
    @State private var viewModel = QuestsCompletedViewModel()
    @State private var selectedTaskForInput: QuestItem? = nil
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                
                // MARK: - Title Card
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Environmentalism Week")
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
                    
                    Image("placeholder")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
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
                            viewModel.completeTask(id: task.id)
                            selectedTaskForInput = task
                        }
                    }
                }
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
        .navigationTitle("Weekly Quest 1")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(item: $selectedTaskForInput) { task in
            QuestInputView(
                viewModel: viewModel,
                task: task)
        }
        .onAppear {
            viewModel.markVideoAsWatched()
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
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}

#Preview {
 QuestsView()
}

