//
//  QuestModel.swift
//  Lenscape-Prototype
//
//  Created by C :) on 28/9/2026.
//

import Foundation

//MARK: - Making Quest change state for home page

struct Quest: Identifiable {
    let id = UUID()
    let title: String
    let unreadTitle: String = "A new weekly quest is out!"
    var isViewed: Bool = false
    
    
    init(title: String = "Community Connection", unreadTitle: String = "A new weekly quest is out!", isViewed: Bool = false) {
        self.title = title
        self.isViewed = isViewed
    }
}

