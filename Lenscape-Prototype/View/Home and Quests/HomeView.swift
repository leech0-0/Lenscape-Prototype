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
    @State private var completedViewModel = QuestsCompletedViewModel()
    
    var body: some View {
        NavigationStack {
            
            ZStack{
                
                LinearGradient(
                    gradient: Gradient (colors: [
                        Color.blue,
                        Color.blue.opacity(0.6),
                        Color.clear
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .containerRelativeFrame(.vertical) { height, axis in
                    height / 3 }
                .frame(maxHeight: .infinity, alignment: .top)
                .ignoresSafeArea()
                
                    Image("homeGraphic")
                        .resizable()
                        .scaledToFit()
                        .offset(y: -236)
                        .ignoresSafeArea()
                
                ScrollView {
                    
                    VStack{
                        Image("titleLM")
                            .resizable()
                            .frame(width: 280, height: 60)
                            .padding()
                            .offset(x: -35)
                        
                    }
                        
                    VStack(alignment: .leading, spacing: 16) {
                        
                        Spacer(minLength: 200)
                        
                        // MARK: - Weekly Quests Section
                        Text("Weekly Quests")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.horizontal)
                        
                        NavigationLink {
                            destinationView
                        } label: {
                            HStack {
                                VStack(alignment: .center, spacing: 12) {
                                    Text(viewModel.questTitle)
                                        .font(.title3)
                                        .fontWeight(.bold)
                                    
                                    Image("placeholder")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 150, height: 150)
                                    
                                    Text(viewModel.buttonTitle) // fake button
                                        .font(.title2)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(.white)
                                        .padding(.horizontal, 20)
                                        .padding(.vertical, 10)
                                        .background(Color.blue, in: Capsule())
                                }
                                .frame(maxWidth: .infinity)
                            }
                            .padding(20)
                            .background(Color.white)
                            .cornerRadius(20)
                        }
                        .buttonStyle(.plain)
                        .padding(.horizontal)
                        
                        // MARK: - Upcoming Events Section
                        Text("Upcoming Events")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.horizontal)
                        
                        NavigationLink(destination: FestivalsView()){
                            HStack {
                                VStack(alignment: .center, spacing: 12) {
                                    Text("City North Shared Futures Festival")
                                        .font(.title3)
                                        .fontWeight(.bold)
                                    
                                    HStack(spacing: 8) {
                                        Image(systemName: "calendar.badge.clock")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 30, height: 30)
                                        
                                        Text("x days to go!")
                                            .fontWeight(.semibold)
                                    }
                                    
                                    Text("See Details") // fake button
                                        .font(.title2)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(.white)
                                        .padding(.horizontal, 20)
                                        .padding(.vertical, 10)
                                        .background(Color.blue, in: Capsule())
                                }
                                .frame(maxWidth: .infinity)
                            }
                            .padding(20)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(20)
                        }
                        .buttonStyle(.plain)
                        .padding(.horizontal)
                    }
                    .padding(.vertical)
                }
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
}
