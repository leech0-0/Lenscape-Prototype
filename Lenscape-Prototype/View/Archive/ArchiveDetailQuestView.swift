//
//  ArchiveDetailQuestView.swift
//  Lenscape-Prototype
//
//  Created by C :) on 13/10/2026.
//


import SwiftUI
import UIKit

struct ArchiveDetailQuestsView: View {

    let week: ArchivedWeek
    
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 22) {

                // Week title
                VStack(alignment: .leading, spacing: 8) {
                    Text(week.title)
                        .font(.title2)
                        .fontWeight(.bold)

                    Text("Your memories")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                // Individual memories
                if week.memories.isEmpty {
                    ContentUnavailableView(
                        "No reflections",
                        systemImage: "book.closed",
                        description: Text(
                            "Your submitted reflections will appear here."
                        )
                    )
                } else {
                    ForEach(week.memories) { memory in
                        VStack(alignment: .leading, spacing: 12) {

                            // Submission date
                            Text(
                                (memory.reflectionDate ?? week.date)
                                    .formatted(
                                        .dateTime
                                            .day()
                                            .month(.abbreviated)
                                            .year()
                                    )
                                    .uppercased()
                            )
                            .font(.caption)
                            .fontWeight(.medium)
                            .foregroundStyle(.primary)
                            .frame(
                                maxWidth: .infinity,
                                alignment: .trailing
                            )

                            // Photo attached to reflection
                            if let imageData = memory.imageData,
                               let image = UIImage(data: imageData) {

                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 210)
                                    .clipped()
                                    .clipShape(
                                        RoundedRectangle(cornerRadius: 14)
                                    )

                            } else {
                                RoundedRectangle(cornerRadius: 14)
                                    .fill(Color.purple.opacity(0.12))
                                    .frame(height: 140)
                                    .overlay {
                                        Image(systemName: "photo")
                                            .font(.system(size: 34))
                                            .foregroundStyle(.purple)
                                    }
                            }

                            // Reflection heading
                            HStack {
                                Text(memory.title)
                                    .font(.headline)
                                    .fontWeight(.bold)

                                Spacer()

                                Image(systemName: "book.closed.fill")
                                    .font(.title3)
                                    .foregroundStyle(.orange)
                            }

                            // Reflection content
                            Text(memory.userReflection)
                                .font(.subheadline)
                                .foregroundStyle(.primary)
                                .frame(
                                    maxWidth: .infinity,
                                    alignment: .leading
                                )

                        }
                        .padding(16)
                        .background(Color("homePageCard"))
                        .clipShape(RoundedRectangle(cornerRadius: 18))
                        .overlay {
                            RoundedRectangle(cornerRadius: 18)
                                .stroke(
                                    Color.purple.opacity(0.18),
                                    lineWidth: 1
                                )
                        }
                    }
                }
            }
            .padding(18)
        }
        .background(Color.purple.opacity(0.07))
        .navigationTitle(week.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        ArchiveDetailQuestsView(
            week: ArchivedWeek(
                title: "Environmentalism Week",
                date: .now,
                imageName: "badgeRegenFull",
                tasks: [
                    QuestItem(
                        title: "Find the Green",
                        description: "Find a piece of urban nature.",
                        isCompleted: true,
                        userReflection: "I noticed a garden I usually walk past.",
                        reflectionDate: .now
                    )
                ]
            )
        )
    }
}

