//
//  ProfileView.swift
//  Lenscape-Prototype
//
//  Created by C :) on 11/9/2026.
//

import SwiftUI

struct ProfileView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some View {
        NavigationStack {
            
            VStack{
                Text("Page under construction, sorry!")
                
                Form {
                    Section("Appearance") {
                        Toggle(isOn: $isDarkMode) {
                            Label(
                                isDarkMode ? "Dark Mode" : "Light Mode",
                                systemImage: isDarkMode
                                ? "moon.fill"
                                : "sun.max.fill"
                            )
                        }
                    }
                }
                .navigationTitle("Profile")
            }
        }
        
        
    }
}

#Preview {
    ProfileView()
}
