//
//  CommunityViewModel.swift
//  Lenscape-Prototype
//
//  Created by C :) on 30/9/2026.
//
import SwiftUI

@Observable
final class CommunityViewModel{
    
    //The quest currently selected in Community
    var selectedTaskID: UUID?
    
    //All community posts
    var communityPosts: [CommunityPost] = []
    
    init() { }
    
    //MARK: - Add Post
    func addPost( post: CommunityPost) {
        communityPosts.append(post)
    }
    
    //MARK: - Posts for Selected Task
    func posts(for taskID: UUID) -> [CommunityPost] {
        communityPosts.filter {
            $0.taskID == taskID
        }
    }
    
    
    //MARK: - Has Reflection
    func hasPosts(for taskID: UUID) -> Bool {
        communityPosts.contains {
            $0.taskID == taskID
        }
    }
}
