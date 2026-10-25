//
//  HomeView.swift
//  Lenscape-Prototype
//
//  Created by C :) on 11/9/2026.
//

import SwiftUI
import AVKit

struct HomeView: View {
    
    @State private var viewModel = QuestsViewModel()
    
    @Environment(QuestsCompletedViewModel.self) private var completedViewModel
    
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                
                // MARK: - Background Gradient
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.blue.opacity(0.6),
                                Color.blue.opacity(0.3),
                                colorScheme == .dark
                                    ? Color.gray.opacity(0.3)
                                    : Color.yellow.opacity(0.3),
                                colorScheme == .dark
                                    ? Color.gray.opacity(0.5)
                                    : Color.yellow.opacity(0.5)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                // MARK: - Decorative Background Images
                ZStack {
                    Image(colorScheme == .dark ? "homeShapesDM" : "homeShapesLM")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 475, height: 500)
                        .offset(y: 100)
                    
                    Image(colorScheme == .dark ? "purpleHexagonDM" : "purpleHexagonLM")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                        .offset(x: 150, y: -90)
                }
                .frame(height: 200)
                
                Spacer()
                
                
                // MARK: - Scrollable Home Content
                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        
                        // MARK: - Title
                        Image(colorScheme == .dark ? "titleDM" : "titleLM")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 250)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 40)
                            .padding(.top, 12)
                        
                        Spacer(minLength: 150)
                        
                        // MARK: - Weekly Quests
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Weekly Quests")
                                .font(.title2)
                                .fontWeight(.bold)
                                .fixedSize(horizontal: false, vertical: true)
                                .padding(.horizontal, 30)
                            
                            NavigationLink {
                                destinationView
                            } label: {
                                VStack(spacing: 12) {
                                    Text(viewModel.questTitle)
                                        .font(.title3)
                                        .fontWeight(.bold)
                                        .multilineTextAlignment(.center)
                                    
                                    HStack {
                                        Image(completedViewModel.communityBadgeImage)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(maxWidth: 130)
                                            .frame(height: 120)
                                            .animation(.easeInOut(duration: 0.3),
                                                       value: completedViewModel.completedReflectionCount)
                                        
                                        VStack{
                                            
                                            Text("A new challenge is waiting...")
                                                .font(.subheadline)
                                                .fontWeight(.semibold)
                                                .fixedSize(
                                                    horizontal: false,
                                                    vertical: true)
                                                .padding(.vertical, 10)
                                            
                                            
                                            Text("Follow along with this week's story to earn the badge!")
                                                .font(.subheadline)
                                                .fontWeight(.semibold)
                                                .fixedSize(
                                                    horizontal: false,
                                                    vertical: true)
                                        }
                                    }
                                    
                                    Text(viewModel.buttonTitle)
                                        .font(.headline)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(.white)
                                        .padding(.horizontal, 20)
                                        .padding(.vertical, 10)
                                        .background(Color.blue, in: Capsule())
                                }
                                .frame(maxWidth: .infinity)
                                .padding(16)
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(Color("homePageCard"))
                                        .shadow(
                                            color: .blue.opacity(0.8),
                                            radius: 0,
                                            x: 7,
                                            y: 7
                                        )
                                )
                                .contentShape(
                                    RoundedRectangle(cornerRadius: 20)
                                )
                            }
                            .buttonStyle(.plain)
                            .padding(.horizontal, 40)
                        }
                        
                        // MARK: - Upcoming Events
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Upcoming Events")
                                .font(.title2)
                                .fontWeight(.bold)
                                .fixedSize(horizontal: false, vertical: true)
                                .padding(.horizontal, 30)
                            
                            NavigationLink {
                                ArchiveFestivalsView()
                            } label: {
                                VStack(spacing: 12) {
                                    Text("City North Shared Futures Festival")
                                        .font(.title3)
                                        .fontWeight(.bold)
                                        .multilineTextAlignment(.center)
                                    
                                    HStack(spacing: 8) {
                                        Image("badgeFestivalFull")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(maxWidth: 130)
                                            .frame(height: 120)
                                        
                                        VStack{
                                            
                                        Text("This event occured on the 3rd of October")
                                            .font(.subheadline)
                                            .fontWeight(.semibold)
                                            .fixedSize(
                                                horizontal: false,
                                                vertical: true)
                                            .padding(.vertical, 10)
                                            
                                            Text("View the Festival Memories in Archive!")
                                                .font(.subheadline)
                                                .fontWeight(.semibold)
                                                .fixedSize(
                                                    horizontal: false,
                                                    vertical: true)
                                    }
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    
                                    Text("View Festival Memories") //fake button
                                        .font(.headline)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(.white)
                                        .padding(.horizontal, 20)
                                        .padding(.vertical, 10)
                                        .background(Color.orange, in: Capsule())
                                }
                                .frame(maxWidth: .infinity)
                                .padding(16)
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(Color("homePageCard"))
                                        .shadow(
                                            color: .orange.opacity(0.8),
                                            radius: 0,
                                            x: 7,
                                            y: 7
                                        ))
                                .contentShape(
                                    RoundedRectangle(cornerRadius: 20)
                                )
                            }
                            .buttonStyle(.plain)
                            .padding(.horizontal, 40)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 24)
                    .frame(maxWidth: 600)
                    .frame(maxWidth: .infinity)
                }
                .scrollIndicators(.hidden)
            }
        }
    }
    
    
    // MARK: - Helper View Builder
    @ViewBuilder
    private var destinationView: some View {
        if viewModel.hasWatchedVideo {
            QuestsView()
        } else {
            QuestsVideoView(viewModel: viewModel)
        }
    }
}

// MARK: - Preview
#Preview {
    HomeView()
        .environment(QuestsCompletedViewModel())
        .environment(CommunityViewModel())
}
