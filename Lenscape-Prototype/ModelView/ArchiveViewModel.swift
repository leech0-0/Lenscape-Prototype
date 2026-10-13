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
    
    init() {}
    
    //MARK: - Weekly Quest Archive
    
    func weeklyQuests(from questsViewModel: QuestsCompletedViewModel) -> [ArchivedWeek] {
        let currentTitle = questsViewModel.currentQuest.title
        
        let currentMemories = questsViewModel.questTasks.filter {
            $0.isCompleted && !$0.userReflection
                .trimmingCharacters(in: .whitespacesAndNewlines)
                .isEmpty
        }
        
        var weeks = archivedWeeks
        
        //include completed reflections from the current week until that week has been archived
        let currentWeekIsArchived = archivedWeeks.contains {
            $0.title == currentTitle
        }
        
        if !currentMemories.isEmpty && !currentWeekIsArchived {
            weeks.append(
                ArchivedWeek(
                    title: currentTitle,
                    date: currentMemories.compactMap {$0.reflectionDate}.max() ?? Date(),
                    tasks: questsViewModel.questTasks
                )
            )
        }
        
        return weeks.sorted {$0.date > $1.date }
    }
    
    // MARK: - Archive a finished week
    
    func archiveCurrentWeek(from questsViewModel: QuestsCompletedViewModel, date: Date = Date()) {
        let title = questsViewModel.currentQuest.title
        
        // prevent the same week's title from being archived twice
        guard !archivedWeeks.contains(where: {$0.title == title })
                else {
            return
        }
        
        let completedTasks = questsViewModel.questTasks.filter {
            $0.isCompleted && !$0.userReflection
                .trimmingCharacters(in: .whitespacesAndNewlines)
                .isEmpty
        }
        
        guard !completedTasks.isEmpty else {
            return
        }
        
        let archivedWeek = ArchivedWeek (
            title: title,
            date: date,
            tasks: completedTasks
        )
        
        archivedWeeks.append(archivedWeek)
        archivedWeeks.sort { $0.date > $1.date }
    }
    
    // MARK: - Memories
    func memoryCount(in week: ArchivedWeek) -> Int {
        week.memories.count
    }
}
