//
//  ArchiveViewModel.swift
//  Lenscape-Prototype
//
//  Created by C :) on 11/9/2026.
//

import SwiftUI
import Observation

@Observable
final class ArchiveViewModel {
    
    
    //MARK: - Completed Weekly Quests that have been archived.
    
    var archivedWeeks: [ArchivedWeek] = []
    
    // MARK: - Festival Archive

    var festivalMemories: [QuestItem] = [
        QuestItem(
            title: "Discover...",
            description: "Walk past at least 3 festival activities",
            isCompleted: true,
            userReflection: "I walked around the main street, there were a numerous amount of activities! I loved the free ice cream",
            imageName: "festivalExploration"
        ),
        QuestItem(
            title: "Meet the maker...",
            description: "After trying a student project, ask the creator/s: 'What do you want people to take away from this game?'",
            isCompleted: true,
            userReflection: "They answered building civic muscles! I loved all projects, they were really meaningful",
            imageName: "festivalConnection"
        ),
        QuestItem(
            title: "Keep it going...",
            description: "Choose one idea, activity or interaction from today's festival that you think should continue beyond the festival",
            isCompleted: true,
            userReflection: "I think all of the projects were really meaningful. I would love to see how their projects change after today",
            imageName: "festivalAction"
        )
    ]

    
    init() { // MARK: - Preloaded Archive: Weekly Quest 1
        
        archivedWeeks.append(
            ArchivedWeek(
                title: "Regeneration",
                date: Calendar.current.date(
                    from: DateComponents(
                        year: 2026,
                        month: 09,
                        day: 29
                    )
                )!,
                imageName: "badgeRegenFull",
                tasks: [
                    // Task 1
                    QuestItem(
                        title: "Take a moment to make one with for a better change in the future",
                        description: "Rohit believes games can help people imagine a better future...",
                        isCompleted: true,
                        userReflection: "I want everyone to be aware of Animal Welfare",
                        imageName: "regenExploration"
                    ),
                    
                    // Task 2
                    QuestItem(
                        title: "Ask someone what they wish for a better future",
                        description: "'The beauty of the game or the fun comes from different perspectives that are coming together'",
                        isCompleted: true,
                        userReflection: "I asked a stranger and they wanted more seating areas in this neighbourhood. This is to spend more time outdoors, relax and interact with others",
                        imageName: "regenConnection"
                    ),
                    
                    // Task 3
                    QuestItem(
                        title: "Share one suggestion for improving your neighbourhood in our community reflection",
                        description: "'What would I do if I have given that power or responsibility to bring the change?'",
                        isCompleted: true,
                        userReflection: "I would love to have more water refill stations around my area, especially in the city during Summer, we shouldn't have to spend money to have something essential to our life.",
                        imageName: "regenAction"
                    )
                ]
            )
        )
        
        // MARK: - Preloaded Archive: Weekly Quest 2
        
        archivedWeeks.append(
            ArchivedWeek(
                title: "Urban and Public Spaces",
                date: Calendar.current.date(
                    from: DateComponents(
                        year: 2026,
                        month: 10,
                        day: 2
                    )
                )!,
                imageName: "badgeUrbanFull",
                tasks: [
                    // Task 1
                    QuestItem(
                        title: "Use your maps to find a park or green space in your city that you haven't gone to before",
                        description: "'I think I pass by a lot of green spaces and different gardens apart from Carlton Gardens'",
                        isCompleted: true,
                        userReflection: "I pass Coburg Lake Reserve with the dog I walk every day",
                        imageName: "urbanExploration"
                    ),
                    
                    // Task 2
                    QuestItem(
                        title: "Share a new place you've discovered with someone",
                        description: "'Whenever I take a walk in any direction, I find something new'",
                        isCompleted: true,
                        userReflection: "This cute stationery shop in Brunswick is really colourful. Such a gem, my creative friends must really like it, will take them there soon",
                        imageName: "urbanConnection"
                    ),
                    
                    // Task 3
                    QuestItem(
                        title: "Visit a local library, park or market with someone",
                        description: "'I also want to go to the mighty Carlton Library right after class'",
                        isCompleted: true,
                        userReflection: "I'm going to the state library to finish my assignments",
                        imageName: "urbanAction"
                    )
                ]
            )
        )
    }
    
    
    // MARK: - Weekly Quest Archive
    
    func weeklyQuests(from questsViewModel: QuestsCompletedViewModel) -> [ArchivedWeek] {
        let currentTitle = questsViewModel.currentQuest.title
        
        let currentMemories = questsViewModel.questTasks.filter {
            $0.isCompleted &&
            !$0.userReflection.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        }
        
        var weeks = archivedWeeks
        
        let currentWeekIsArchived = archivedWeeks.contains {
            $0.title == currentTitle
        }
        
        if !currentMemories.isEmpty && !currentWeekIsArchived {
            weeks.append(
                ArchivedWeek(
                    title: currentTitle,
                    date: currentMemories.compactMap { $0.reflectionDate }.max() ?? Date(),
                    imageName: questsViewModel.communityBadgeImage,
                    tasks: currentMemories
                )
            )
        }
        
        return weeks.sorted { $0.date > $1.date }
    }
    
   //MARK: - Archive Current Week
    
    func archiveCurrentWeek(
        from questsViewModel: QuestsCompletedViewModel,
        badgeImageName: String,
        date: Date = Date()
    ) {
        let title = questsViewModel.currentQuest.title

        guard !archivedWeeks.contains(where: { $0.title == title }) else {
            return
        }

        let completedTasks = questsViewModel.questTasks.filter {
            $0.isCompleted &&
            !$0.userReflection.trimmingCharacters(
                in: .whitespacesAndNewlines
            ).isEmpty
        }

        guard !completedTasks.isEmpty else {
            return
        }

        let archivedWeek = ArchivedWeek(
            title: title,
            date: date,
            imageName: badgeImageName,
            tasks: completedTasks
        )

        archivedWeeks.append(archivedWeek)
        archivedWeeks.sort { $0.date > $1.date }
    }

    
    // MARK: - Badge Images
    
    private func badgeImageName(for title: String) -> String {
        switch title {
        case "Regeneration":
            return "badgeRegenFull"
            
        case "Urban and Public Spaces":
            return "badgeUrbanFull"
            
        default:
            return "badgeRegen0"
        }
    }
    
    // MARK: - Memories
    
    func memoryCount(in week: ArchivedWeek) -> Int {
        week.memories.count
    }
}
