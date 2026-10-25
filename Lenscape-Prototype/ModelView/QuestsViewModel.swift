//
//  QuestsViewModel.swift
//  Lenscape-Prototype
//
//  Created by C :) on 11/9/2026.
//
import SwiftUI
import SwiftData

//MARK: - Changing status on home page

@Observable
final class QuestsViewModel {
    init() { }
    var currentQuest = Quest()
    var hasWatchedVideo: Bool = false
    
    //Dynamic properties driven by state
    var questTitle: String {
        currentQuest.isViewed ? currentQuest.title : currentQuest.unreadTitle
    }
    
    var buttonTitle: String {
        currentQuest.isViewed ? "Continue" : "Check it out!"
    }
    
    func markVideoAsWatched() {
        currentQuest.isViewed = true
        hasWatchedVideo = true
    }
    
    
}

//MARK: - Completed Quests ViewModel
@Observable
final class QuestsCompletedViewModel {
    init() { }
    var currentQuest = Quest()
    var hasWatchedVideo: Bool = false
    
    // Sub-tasks for the active quest
    var questTasks: [QuestItem] = [
        QuestItem(
            id: UUID(uuidString:
                        "11111111-1111-1111-1111-111111111111")!,
            title: "Find a local place you would love to visit and plan to go with a friend ",
            description: "Jezlyne thinks that food always connects people..."
        ),
        QuestItem(
            id: UUID(uuidString:
                        "22222222-2222-2222-2222-222222222222")!,
            title: "Remind someone it's OK to take a break",
            description: "'It's OK to rest...'"
        ),
        QuestItem(
            id: UUID(uuidString:
                        "33333333-3333-3333-3333-333333333333")!,
            title: "Plan a time to catch up with someone that you haven't seen in a while",
            description: "'One of the ways to have fun could be from going to cafe's...'"
        )
    ]
    
    var completedReflectionCount: Int {
        questTasks.filter { task in
            task.isCompleted && !task.userReflection.trimmingCharacters(in: .whitespacesAndNewlines)
                .isEmpty
        }.count
    }
    
    var communityBadgeImage: String {
        switch completedReflectionCount {
        case 0:
            return "badgeComCon0"
        case 1:
            return "badgeComCon30"
        case 2:
            return "badgeComCon60"
        default:
            return "badgeComConFull"
        }
    }
    
    // Shared posts stored for CommunityView
    var communityPosts: [CommunityPost] = []
    
    var questTitle: String {
        currentQuest.isViewed ? currentQuest.title : currentQuest.unreadTitle
    }
    
    var buttonTitle: String {
        currentQuest.isViewed ? "Continue" : "Check it out"
    }
    
    
    func markVideoAsWatched() {
        hasWatchedVideo = true
        currentQuest.isViewed = true
    }
    
//MARK: - Submit Reflection
    func submitReflection(
        for taskID: UUID,
        reflectionText: String,
        imageData: Data?,
        modelContext: ModelContext
    ){
        guard let index = questTasks.firstIndex(
            where: { $0.id == taskID }
        ) else {
            return
        }
        
        let cleanedReflection = reflectionText.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !cleanedReflection.isEmpty else {
            return
        }
        
        let submissionDate = Date()
        
       //Update the task that will be displayed in the archive.
        questTasks[index].isCompleted = true
        questTasks[index].userReflection = cleanedReflection
        questTasks[index].reflectionDate = submissionDate
        questTasks[index].imageData = imageData
        
        do {
            // Look for an existing community post for this task
            let descriptor = FetchDescriptor<CommunityPost>(
                predicate: #Predicate {
                    $0.taskID == taskID
                }
            )
            
            let existingPosts = try modelContext.fetch(descriptor)
            
            if let existingPost = existingPosts.first {
                //EDIT: Update the existing post
                existingPost.questTitle = questTasks[index].title
                existingPost.userReflection = cleanedReflection
                existingPost.dateSubmitted = submissionDate
                existingPost.imageData = imageData
            } else {
                // NEW: Create a post if none exists
                let newPost = CommunityPost(
                    taskID: taskID,
                    questTitle: questTasks[index].title,
                    userReflection: cleanedReflection,
                    dateSubmitted: submissionDate,
                    imageData: imageData
                )
                
                modelContext.insert(newPost)
            }
            
            try modelContext.save()
            
        } catch {
            print("Failed to save reflection: \(error)")
        }
    }
    
    
    func deleteReflection(
        for taskID: UUID,
        modelContext: ModelContext
    ) {
        let descriptor = FetchDescriptor<CommunityPost>(
            predicate: #Predicate {
                $0.taskID == taskID
            }
        )

        do {
            let posts = try modelContext.fetch(descriptor)

            for post in posts {
                modelContext.delete(post)
            }

            try modelContext.save()

            // Reset the in-memory task as well.
            if let index = questTasks.firstIndex(
                where: { $0.id == taskID }
            ) {
                questTasks[index].userReflection = ""
                questTasks[index].isCompleted = false
                questTasks[index].reflectionDate = nil
                questTasks[index].imageData = nil
            }

            print("Reflection deleted successfully.")

        } catch {
            print("Failed to delete reflection: \(error)")
        }
    }
    
}


