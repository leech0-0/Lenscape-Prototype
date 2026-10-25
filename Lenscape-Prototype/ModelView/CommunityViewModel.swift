//
//  CommunityViewModel.swift
//  Lenscape-Prototype
//
//  Created by C :) on 30/9/2026.
//

import SwiftUI

@Observable
final class CommunityViewModel {

    // The quest currently selected in Community
    var selectedTaskID: UUID?

    // User-submitted community posts
    var communityPosts: [CommunityPost] = []

    // MARK: - Example Reflections for Each Quest

    let exampleReflections: [[CommunityExampleReflection]] = [

        // Quest 1
        [
            CommunityExampleReflection(
                text: "This pretty coffee shop is a perfect place to hang out with my girlies! I believe they would love here with all these decors and delicious brunch!!",
                imageName: "jolieExploration"
            ),
            CommunityExampleReflection(
                text: "I found an Italian restaurant...Delicious(¯﹃¯)",
                imageName: "yuliaExploration"
            ),
            CommunityExampleReflection(
                text: "I found a new Thai place around my area",
                imageName: "myExploration"
            ),
            CommunityExampleReflection(
                text: "I had a look on Google Maps, they do picnics in Royal Botanic Garden. ",
                imageName: "vanessaExploration"
            )
        ],

        // Quest 2
        [
            CommunityExampleReflection(
                text: "I texted my friend to take a break and she is sleeping now",
                imageName: "yuliaConnection"
            ),
            CommunityExampleReflection(
                text: "I called my mum and checked in on her, shes really stressed with work so we've planned to go to mini golf tonight and get an ice cream to cheer her up",
                imageName: "myConnection"
            ),
            CommunityExampleReflection(
                text: "I texted my bff to take a rest. She had loads of assignments this weekkkkk",
                imageName: "vanessaConnection"
            ),
            CommunityExampleReflection(
                text: "Sometimes I forgot, but today I journaled to myself that I deserve a break too! I want to treat myself better and take care of myself to go through hard days.. Take it easy!!",
                imageName: "jolieConnection"
            )
        ],

        // Quest 3
        [
            CommunityExampleReflection(
                text: "I'm catching up with my classmate tomorrow in the city. We're going to eat Korean BBQ",
                imageName: "vanessaAction"
            ),
            CommunityExampleReflection(
                text: "Yeah we'll meet up tomorrow and share milk tea together at 2PM",
                imageName: "yuliaAction"
            ),
            CommunityExampleReflection(
                text: "Finally I got to set up a date with my best friend as we've been all busy with study and work. We will hang out a whole day in early Nov to celebrate her birthday! And this is a place we've always wanted to visit, so we will go this time! Excited",
                imageName: "jolieAction"
            ),
            CommunityExampleReflection(
                text: "My friend is always super busy but I'm hoping we can plan a time soon that will work with her schedule",
                imageName: "myAction"
            )
        ]
    ]

    init() { }

    // MARK: - Add Post
    func addPost(post: CommunityPost) {
        if let existingIndex = communityPosts.firstIndex(
            where: { $0.taskID == post.taskID }
        ) {
            communityPosts[existingIndex] = post
        } else {
            communityPosts.append(post)
        }
    }

    // MARK: - Posts for Selected Task
    func posts(for taskID: UUID) -> [CommunityPost] {
        communityPosts.filter {
            $0.taskID == taskID
        }
    }

    // MARK: - Has Reflection
    func hasPosts(for taskID: UUID) -> Bool {
        communityPosts.contains {
            $0.taskID == taskID
        }
    }

    // MARK: - Example Reflections for Selected Quest
    func examples(for questIndex: Int) -> [CommunityExampleReflection] {
        guard exampleReflections.indices.contains(questIndex) else {
            return []
        }

        return exampleReflections[questIndex]
    }
}
