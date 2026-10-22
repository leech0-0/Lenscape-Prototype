//
//  QuestVideoView.swift
//  Lenscape-Prototype
//

import SwiftUI
import AVKit

struct ArchVideoRegenView: View {
    var viewModel: QuestsViewModel
    
    @Environment(\.colorScheme) private var colorScheme
    
    //initialise AVPlayer with local video
    var player: AVPlayer {
        if let url = Bundle.main.url(forResource: "regenVideo", withExtension: ".mp4") {
            return AVPlayer(url: url)
        }
        return AVPlayer()
    }
    
    var body: some View {
        ScrollView{
            VStack(spacing: 24) {
                Text("Board to the Future with Rohit")
                    .font(.title2)
                    .bold()
                    .padding(.top)
                
//     see if they want this           Text("This week's video focuses on ... ")
                
                // Embedded Video Player
                VideoPlayer(player: player)
                    .frame(height: 660)
                    .cornerRadius(16)
                    .padding(.horizontal)
                    .onAppear {
                        player.play()
                    }
                    .onDisappear {
                        player.pause()
                    }
                
                Spacer()
                
                // Proceed to the actual QuestsView
                NavigationLink(destination: ArchiveWeeklyQuestsView()){
                    Text("Back to Archived Quests")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.purple, in: RoundedRectangle(cornerRadius: 14))
                }
                .padding(.horizontal)
                .simultaneousGesture(TapGesture().onEnded {
                    viewModel.markVideoAsWatched()
                })
                ZStack {
                    Image(colorScheme == .dark ? "holdingUpDM" : "holdingUpLM")
                        .resizable()
                        .frame(width: 250, height: 100)
                        .offset(y: -20)
                }
            }
            .navigationTitle("Archived Video")
            .navigationBarTitleDisplayMode(.inline)
            // put colour in here after fixing up the QuestsView
            
            
        }
    }
}

#Preview {
    ArchVideoRegenView(viewModel: QuestsViewModel())
}
