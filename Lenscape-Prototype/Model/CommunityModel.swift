//
//  CommunityModel.swift
//  Lenscape-Prototype
//
//  Created by C :) on 28/9/2026.
//

import SwiftData
import Foundation

struct QuestItem: Identifiable {
    let id: UUID
    let title: String
    let description: String
    var isCompleted: Bool = false
    var userReflection: String = ""
    var reflectionDate: Date?
    var imageData: Data?
    
    init(
        id: UUID = UUID(),
        title: String,
        description: String,
        isCompleted: Bool = false,
        userReflection: String = "",
        reflectionDate: Date? = nil,
        imageData: Data? = nil
    ){
        self.id = id
        self.title = title
        self.description = description
        self.isCompleted = isCompleted
        self.userReflection = userReflection
        self.reflectionDate = reflectionDate
        self.imageData = imageData
    }
    
}

@Model
final class CommunityPost {
    
    //one community reflection per task
    @Attribute(.unique) var taskID: UUID
    
   
    //Which task this reflection belongs to
    var questTitle: String
    var userReflection: String
    var dateSubmitted: Date
    var imageData: Data?
    
    init(
        taskID: UUID,
        questTitle: String,
        userReflection: String,
        dateSubmitted: Date = Date(),
        imageData: Data? = nil
    ){
        self.taskID = taskID
        self.questTitle = questTitle
        self.userReflection = userReflection
        self.dateSubmitted = dateSubmitted
        self.imageData = imageData
    }
}
