//
//  FestivalsView.swift
//  Lenscape-Prototype
//
//  Created by C :) on 28/9/2026.
//

import SwiftUI
import AVKit

struct FestivalsView: View {
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack{
                    Text("City North Shared Futures Festival")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Divider()
                    
                    Text("Page under construction, sorry!")
                        .font(.title3)
                }
            }
        }
    }
}

#Preview{
    FestivalsView()
}
