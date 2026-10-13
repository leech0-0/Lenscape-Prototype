//
//  CommunityModel.swift
//  Lenscape-Prototype
//
//  Created by C :) on 28/9/2026.
//

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

struct CommunityPost: Identifiable {
    let id: UUID
    //Which task this reflection belongs to
    let taskID: UUID
    let questTitle: String
    let userReflection: String
    let dateSubmitted: Date
    var imageData: Data?
    
    init(
        id: UUID = UUID(),
        taskID: UUID,
        questTitle: String,
        userReflection: String,
        dateSubmitted: Date = Date(),
        imageData: Data? = nil
    ){
        self.id = id
        self.taskID = taskID
        self.questTitle = questTitle
        self.userReflection = userReflection
        self.dateSubmitted = dateSubmitted
        self.imageData = imageData
    }
}
