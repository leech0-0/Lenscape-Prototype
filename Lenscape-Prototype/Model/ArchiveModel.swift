//
//  ArchiveModel.swift
//  Lenscape-Prototype
//
//  Created by C :) on 13/10/2026.
//

import Foundation

struct ArchivedWeek: Identifiable {
    let id: UUID
    let title: String
    let date: Date
    var imageName: String? = nil
    let tasks: [QuestItem]
    
    init(
        id: UUID = UUID(),
        title: String,
        date: Date,
        imageName: String,
        tasks: [QuestItem]
    ){
        self.id = id
        self.title = title
        self.date = date
        self.imageName = imageName
        self.tasks = tasks
        
    }
    
    var memories: [QuestItem] {
        tasks.filter { $0.isCompleted && !$0.userReflection.isEmpty }
    }
    
}
