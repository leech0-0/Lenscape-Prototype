//
//  CommunityModel.swift
//  Lenscape-Prototype
//
//  Created by C :) on 28/9/2026.
//

import Foundation

struct QuestItem: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    var isCompleted: Bool = false
    var userReflection: String = ""
    
}

struct CommunityPost: Identifiable {
    let id = UUID()
    
    //Which task this reflection belongs to
    let taskID: UUID
    
    let questTitle: String
    let userReflection: String
    let dateSubmitted: Date = Date()
    
}
