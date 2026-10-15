//
//  ArchiveView.swift
//  Lenscape-Prototype
//
//  Created by C :) on 11/9/2026.
//


import SwiftUI

struct ArchiveWeeklyQuestsView: View {

    @Environment(ArchiveViewModel.self) private var archiveViewModel
    @Environment(QuestsCompletedViewModel.self) private var questsViewModel

    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]

    private var weeks: [ArchivedWeek] {
        archiveViewModel.weeklyQuests(from: questsViewModel)
    }

    private var monthHeading: String {
        weeks.first?.date.formatted(.dateTime.month(.wide).year())
            ?? Date.now.formatted(.dateTime.month(.wide).year())
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 18) {

                Text("Weekly Archive")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Rectangle()
                    .fill(Color.primary.opacity(0.7))
                    .frame(height: 1)

                Text(monthHeading)
                    .font(.headline)

                if weeks.isEmpty {
                    ContentUnavailableView(
                        "No memories yet",
                        systemImage: "book.closed",
                        description: Text(
                            "Complete a weekly quest and submit a reflection to see it here."
                        )
                    )
                    .padding(.top, 30)

                } else {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(weeks) { week in
                            NavigationLink {
                                ArchiveDetailQuestsView(week: week)
                            } label: {
                                WeeklyArchiveCard(week: week)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
            }
            .padding(18)
        }
        .background(Color.purple.opacity(0.07))
        .navigationTitle("Weekly Archive")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Weekly archive card

private struct WeeklyArchiveCard: View {

    let week: ArchivedWeek

    private var memoryCount: Int {
        week.memories.count
    }

    var body: some View {
        VStack(spacing: 12) {

            Text(week.title)
                .font(.headline)
                .multilineTextAlignment(.center)
                .foregroundStyle(.primary)
                .lineLimit(3)
                .frame(maxWidth: .infinity, minHeight: 54)

            ZStack {
                Rectangle()
                    .fill(Color.gray.opacity(0.14))

                Image(systemName: "play.circle.fill")
                    .font(.system(size: 34))
                    .foregroundStyle(.gray.opacity(0.6))
            }
            .frame(height: 76)
            .padding(.horizontal, 6)

            Text(memoryCount == 1 ? "1 Memory" : "\(memoryCount) Memories")
                .font(.caption)
                .foregroundStyle(.white)
                .padding(.horizontal, 14)
                .padding(.vertical, 7)
                .background(Color.purple.opacity(0.75), in: Capsule())

            Spacer(minLength: 4)

            Image(systemName: "hexagon")
                .font(.system(size: 46))
                .foregroundStyle(.orange)
                .overlay {
                    Image(systemName: "leaf.fill")
                        .font(.system(size: 20))
                        .foregroundStyle(.green)
                }
                .padding(.bottom, 4)
        }
        .padding(10)
        .frame(maxWidth: .infinity)
        .frame(height: 255)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .overlay {
            RoundedRectangle(cornerRadius: 18)
                .stroke(Color.purple.opacity(0.25), lineWidth: 1)
        }
        .shadow(color: .purple.opacity(0.12), radius: 2, x: 2, y: 4)
    }
}

#Preview {
    NavigationStack {
        ArchiveWeeklyQuestsView()
    }
    .environment(ArchiveViewModel())
    .environment(QuestsCompletedViewModel())
}

