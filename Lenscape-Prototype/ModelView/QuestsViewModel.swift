//
//  QuestsViewModel.swift
//  Lenscape-Prototype
//
//  Created by C :) on 11/9/2026.
//
import SwiftUI

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
            title: "Find the Green",
            description: "Find a piece of urban nature you normally walk past. Stop and observe it for a moment."
        ),
        QuestItem(
            title: "Different Generations",
            description: "Ask someone older/younger than you how the local environment has changed during their lifetime."
        ),
        QuestItem(
            title: "Bring your own",
            description: "Use your own bottle, cup or bag today."
        )
    ]
    
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
        communityViewModel: CommunityViewModel
    ){
        guard let index = questTasks.firstIndex(
            where: { $0.id == taskID }
        ) else {
            return
        }
        
        //Task is ONLY Completed after reflection is submitted
        questTasks[index].isCompleted = true
        
        questTasks[index].userReflection = reflectionText
        
        //Create community post
        let newPost = CommunityPost(
            taskID: taskID,
            questTitle: questTasks[index].title,
            userReflection: reflectionText
        )
        
        
        //Send reflection to Community
        communityViewModel.addPost(post: newPost)
    }
}

