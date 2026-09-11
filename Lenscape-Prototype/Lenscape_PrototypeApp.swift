//
//  Lenscape_PrototypeApp.swift
//  Lenscape-Prototype
//
//  Created by C :) on 11/9/2026.
//

import SwiftUI

@main
struct Lenscape_PrototypeApp: App {
    var body: some Scene {
        WindowGroup {
            TabView{
                
                HomeView()
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                
                ArchiveView()
                    .tabItem {
                        Label("Archive", systemImage: "book.fill")
                    }
                
                CommunityView()
                    .tabItem {
                        Label("Community", systemImage: "person.3.fill")
                    }
                
                ProfileView()
                    .tabItem {
                        Label("Profile", systemImage: "gearshape.fill")
                    }
                
            }
            
        }
    }
}
