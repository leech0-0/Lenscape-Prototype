//
//  ArchiveView.swift
//  Lenscape-Prototype
//
//  Created by C :) on 11/9/2026.
//



import SwiftUI
import UIKit

struct ArchiveFestivalsView: View {

    @Environment(ArchiveViewModel.self) private var archiveViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 22) {

                // Festival archive heading
                VStack(alignment: .leading, spacing: 8) {
                    Text("Festival Archive")
                        .font(.title2)
                        .fontWeight(.bold)

                    Text("Your festival memories")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                Rectangle()
                    .fill(Color.primary.opacity(0.7))
                    .frame(height: 1)

                // Festival memories
                if archiveViewModel.festivalMemories.isEmpty {

                    ContentUnavailableView(
                        "No festival memories",
                        systemImage: "book.closed",
                        description: Text(
                            "Your saved festival reflections will appear here."
                        )
                    )

                } else {

                    ForEach(archiveViewModel.festivalMemories) { memory in

                        VStack(alignment: .leading, spacing: 12) {

                            // Memory date
                            Text(
                                (memory.reflectionDate ?? Date.now)
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

                            // Memory image
                            if let imageData = memory.imageData,
                               let image = UIImage(data: imageData) {

                                // User-uploaded photo
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 210)
                                    .clipped()
                                    .clipShape(
                                        RoundedRectangle(cornerRadius: 14)
                                    )

                            } else if !memory.imageName.isEmpty {

                                // Image from Assets.xcassets
                                Image(memory.imageName)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 210)
                                    .clipped()
                                    .clipShape(
                                        RoundedRectangle(cornerRadius: 14)
                                    )

                            } else {

                                // Default image
                                Image("myAction")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 210)
                                    .clipped()
                                    .clipShape(
                                        RoundedRectangle(cornerRadius: 14)
                                    )
                            }

                            // Memory heading
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
                        .clipShape(
                            RoundedRectangle(cornerRadius: 18)
                        )
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
        .navigationTitle("Festival Archive")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        ArchiveFestivalsView()
            .environment(ArchiveViewModel())
    }
}
