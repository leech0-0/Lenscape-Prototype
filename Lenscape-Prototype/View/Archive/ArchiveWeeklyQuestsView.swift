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
    
    @Environment(\.colorScheme) private var colorScheme

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
        .background(colorScheme == .dark ? Color.gray.opacity(0.5) : Color("archBackground").opacity(0.2))
    }
}

// MARK: - Weekly archive card

private struct WeeklyArchiveCard: View {
    
    @Environment(\.colorScheme) private var colorScheme

    let week: ArchivedWeek

    private var memoryCount: Int {
        week.memories.count
    }
    
    private var thumbnailImageName: String {
        switch week.title {
        case "Urban and Public Spaces":
            return "commConThumbnail"

        case "Regeneration":
            return "regenThumbnail"

        default:
            return "regenThumbnail"
        }
    }

    var body: some View {
        VStack(spacing: 12) {

            Text(week.title)
                .font(.headline)
                .multilineTextAlignment(.center)
                .foregroundStyle(.primary)
                .lineLimit(3)
                .frame(maxWidth: .infinity, minHeight: 54)

            NavigationLink {
                Group {
                    switch week.title {
                    case "Urban and Public Spaces":
                        ArchVideoUrbanView(viewModel: QuestsViewModel())

                    case "Regeneration":
                        ArchVideoRegenView(viewModel: QuestsViewModel())

                    default:
                        ContentUnavailableView(
                            "Video unavailable",
                            systemImage: "video.slash",
                            description: Text("There is no video available for this quest yet.")
                        )
                    }
                }
            } label: {
                ZStack {

                    Image(thumbnailImageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 250)


                    Text("Click here to watch the archived video!")
                        .font(.caption)
                        .offset(y: 150)
                        .padding()
                }
                .frame(height: 250)
                .padding(.horizontal, 6)
                .padding(.bottom, 20)
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)

            Text("")
            
            Text(memoryCount == 1 ? "1 Memory" : "\(memoryCount) Memories")
                .font(.caption)
                .foregroundStyle(.white)
                .padding(.horizontal, 14)
                .padding(.vertical, 7)
                .background(Color.purple.opacity(0.75), in: Capsule())

            Spacer(minLength: 1)

            Image(week.imageName ?? "badgeRegen0")
                .resizable()
                .frame(width: 100, height: 100)
                .padding(.bottom, 10)
        }
        .padding(10)
        .frame(maxWidth: .infinity)
        .frame(height: 550)
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

