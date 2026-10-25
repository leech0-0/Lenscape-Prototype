//
//  ProfileView.swift
//  Lenscape-Prototype
//
//  Created by C :) on 11/9/2026.
//


import SwiftUI

struct ProfileView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    @Environment(QuestsCompletedViewModel.self) private var completedViewModel
    
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        NavigationStack {
            ZStack {
                // MARK: - Background Gradient
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.orange.opacity(0.6),
                        Color.orange.opacity(0.3),
                        colorScheme == .dark
                        ? Color.gray.opacity(0.3)
                        : Color.yellow.opacity(0.3),
                        colorScheme == .dark
                        ? Color.gray.opacity(0.5)
                        : Color.yellow.opacity(0.1)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
            ScrollView {
                    VStack(spacing: 28) {
                        
                        // MARK: - Profile
                        
                        VStack(spacing: 20) {
                            Text("Profile")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .frame(
                                    maxWidth: .infinity,
                                    alignment: .leading
                                )
                            
                            // Replace with your profile image asset
                            HStack{
                                VStack{
                                    Text("Bella Ridley")
                                        .font(.title)
                                        .fontWeight(.bold)
                                    
                                    Text("@bella.ridley")
                                        
                                }
                                
                                Spacer()
                                
                                Image(colorScheme == .dark ? "videoShapeDM" : "videoShapeLM")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 100, height: 100)
                            }
                            .padding()
                            
                            Text("Current badge progress:")
                                .font(.title2)
                                .fontWeight(.bold)
                            
                            Text("Complete more tasks to collect this week's badge!")
                                .fontWeight(.semibold)
                            
                            //replace with badge progress
                            Image(completedViewModel.communityBadgeImage)
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: 130)
                                .frame(height: 120)
                                .animation(.easeInOut(duration: 0.3),
                                           value: completedViewModel.completedReflectionCount)
                            
                        }
                        
                        // MARK: - Rewards
                        
                        VStack(alignment: .leading, spacing: 20) {
                            HStack {
                                Text("Collected Badges")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                
                                Spacer()
                                
                            }
                            
                            HStack {
                                Image("badgeRegenFull")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 90, height: 90)
                                
                                Spacer()
                                
                                Image("badgeUrbanFull")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 90, height: 90)
                                
                                Spacer()
                                
                                Image("badgeFestivalFull")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 90, height: 90)
                            }
                        }
                        
                        // MARK: - Appearance
                        
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Appearance")
                                .font(.title2)
                                .fontWeight(.bold)
                            
                            Toggle(isOn: $isDarkMode) {
                                Label(
                                    isDarkMode ? "Dark Mode" : "Light Mode",
                                    systemImage: isDarkMode
                                    ? "moon.fill"
                                    : "sun.max.fill"
                                )
                            }
                        }
                        .padding(16)
                        .background(
                            Color("homePageCard"),
                            in: RoundedRectangle(cornerRadius: 16)
                        )
                    }
                    .padding(20)
                }
                .navigationBarHidden(true)
            }
            .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}

#Preview {
    ProfileView()
        .environment(QuestsCompletedViewModel())
}
