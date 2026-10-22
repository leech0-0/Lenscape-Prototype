//
//  ArchiveView.swift
//  Lenscape-Prototype
//
//  Created by C :) on 11/9/2026.
//


import SwiftUI

struct ArchiveView: View {
    
    @Environment(ArchiveViewModel.self) private var archiveViewModel
    
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        NavigationStack {
            
            // MARK: - Background Gradient
            ZStack(alignment: .top) {
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color("archBackground").opacity(0.5),
                        Color("archBackground").opacity(0.6),
                        colorScheme == .dark
                        ? Color.gray.opacity(0.3)
                        : Color.white.opacity(0.3),
                        colorScheme == .dark
                        ? Color.gray.opacity(0.5)
                        : Color.white.opacity(0.5)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        
                        // Header
                        HStack(alignment: .center) {
                            Text("Archive")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                            
                            Spacer(minLength: 10)
                            
                            Image(colorScheme == .dark ? "archiveShapeDM" : "archiveShapeLM")
                                .resizable()
                                .frame(width: 125, height: 125)
                        }
                        
                        // Weekly quests category
                        NavigationLink {
                            ArchiveWeeklyQuestsView()
                        } label: {
                            ArchiveCategoryCard(
                                title: "Weekly Quests",
                                subtitle: "Revisit your past quests and memories",
                                imageName: colorScheme == .dark ? "questArchiveDM" : "questArchiveLM",
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
                                imageName: colorScheme == .dark ? "festivalArchiveDM" : "festivalArchiveLM",
                                accent: Color.orange.opacity(0.35)
                            )
                        }
                        .buttonStyle(.plain)
                        
                        Spacer(minLength: 16)
                    }
                    .padding(20)
                }
                .toolbar(.hidden, for: .navigationBar)
            }
        }
    }
}

// MARK: - Reusable category card

private struct ArchiveCategoryCard: View {

    let title: String
    let subtitle: String
    let imageName: String
    let accent: Color

    var body: some View {
        HStack(spacing: 0) {

            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(accent)

                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .padding()
            }
            .frame(width: 125)

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
        .frame(minHeight: 300)
        .background(Color("homePageCard"))
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
