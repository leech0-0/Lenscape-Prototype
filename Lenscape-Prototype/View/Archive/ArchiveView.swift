//
//  ArchiveView.swift
//  Lenscape-Prototype
//
//  Created by C :) on 11/9/2026.
//


import SwiftUI

struct ArchiveView: View {

    @Environment(ArchiveViewModel.self) private var archiveViewModel

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {

                    // Header
                    HStack(alignment: .center) {
                        Text("Archive")
                            .font(.largeTitle)
                            .fontWeight(.bold)

                    }

                    Rectangle()
                        .fill(Color.primary.opacity(0.7))
                        .frame(height: 1)

                    // Weekly quests category
                    NavigationLink {
                        ArchiveWeeklyQuestsView()
                    } label: {
                        ArchiveCategoryCard(
                            title: "Weekly Quests",
                            subtitle: "Revisit your past quests and memories",
                            symbol: "leaf.fill",
                            accent: Color.purple.opacity(0.22)
                        )
                    }
                    .buttonStyle(.plain)

                    // Festival category
                    NavigationLink {
                        ArchiveFestivalsView()
                    } label: {
                        ArchiveCategoryCard(
                            title: "Festival Archive",
                            subtitle: "Look back on your festival experiences",
                            symbol: "ticket.fill",
                            accent: Color.orange.opacity(0.35)
                        )
                    }
                    .buttonStyle(.plain)

                    Spacer(minLength: 16)
                }
                .padding(20)
            }
            .background(Color.purple.opacity(0.07))
            .toolbar(.hidden, for: .navigationBar)
        }
    }
}

// MARK: - Reusable category card

private struct ArchiveCategoryCard: View {

    let title: String
    let subtitle: String
    let symbol: String
    let accent: Color

    var body: some View {
        HStack(spacing: 0) {

            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(accent)

                Image(systemName: symbol)
                    .font(.system(size: 38, weight: .medium))
                    .foregroundStyle(.primary)
            }
            .frame(width: 100)

            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(.primary)

                Text(subtitle)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.leading)

                HStack {
                    Spacer()
                    Image(systemName: "chevron.right")
                        .font(.headline)
                        .foregroundStyle(.purple)
                }
            }
            .padding(16)
        }
        .frame(minHeight: 136)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay {
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.purple.opacity(0.2), lineWidth: 1)
        }
        .shadow(color: .purple.opacity(0.12), radius: 2, x: 2, y: 4)
    }
}

#Preview {
    ArchiveView()
        .environment(ArchiveViewModel())
        .environment(QuestsCompletedViewModel())
}
