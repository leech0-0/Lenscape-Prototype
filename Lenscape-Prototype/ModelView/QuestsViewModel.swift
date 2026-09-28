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
    var currentQuest = Quest()
    
    //Dunamic properties driven by state
    var questTitle: String {
        currentQuest.isViewed ? currentQuest.title : currentQuest.unreadTitle
    }
    
    var buttonTitle: String {
        currentQuest.isViewed ? "Continue" : "Check it out!"
    }
    
    func markQuestAsViewed() {
        currentQuest.isViewed = true
    }
}
