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
                        title: "Rohit believes games can help people imagine a better future...",
                        description: "Take a moment to make one with for a better change in the future",
                        isCompleted: true,
                        userReflection: "TESTER REFLECTION - Quest 1"
                    ),
                    
                    // Task 2
                    QuestItem(
                        title: "'The beauty of the game or the fun comes from different perspectives that are coming together'",
                        description: "Ask someone what they wish for a better future",
                        isCompleted: true,
                        userReflection: "TESTER REFLECTION - Quest 2"
                    ),
                    
                    // Task 3
                    QuestItem(
                        title: "'What would I do if I have given that power or responsibility to bring the change?'",
                        description: "Share one suggestion for improving your neighbourhood in our community reflection",
                        isCompleted: true,
                        userReflection: "TESTER REFLECTION - Quest 3"
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
                        userReflection: "TESTER REFLECTION - Quest 1"
                    ),
                    
                    // Task 2
                    QuestItem(
                        title: "Share a new place you've discovered with someone",
                        description: "'Whenever I take a walk in any direction, I find something new'",
                        isCompleted: true,
                        userReflection: "TESTER REFLECTION - Quest 2"
                    ),
                    
                    // Task 3
                    QuestItem(
                        title: "Visit a local library, park or market with someone",
                        description: "'I also want to go to the mighty Carlton Library right after class'",
                        isCompleted: true,
                        userReflection: "TESTER REFLECTION - Quest 3"
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
                    imageName: badgeImageName(for: currentTitle),
                    tasks: currentMemories
                )
            )
        }
        
        return weeks.sorted { $0.date > $1.date }
    }
    
    // MARK: - Archive a finished week
    
    func archiveCurrentWeek(
        from questsViewModel: QuestsCompletedViewModel,
        date: Date = Date()
    ) {
        let title = questsViewModel.currentQuest.title
        
        // Prevent the same week's title from being archived twice.
        guard !archivedWeeks.contains(where: { $0.title == title }) else {
            return
        }
        
        let completedTasks = questsViewModel.questTasks.filter {
            $0.isCompleted &&
            !$0.userReflection.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        }
        
        guard !completedTasks.isEmpty else {
            return
        }
        
        let archivedWeek = ArchivedWeek(
            title: title,
            date: date,
            imageName: badgeImageName(for: title),
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
