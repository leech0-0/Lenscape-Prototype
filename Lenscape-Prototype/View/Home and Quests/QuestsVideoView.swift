//
//  QuestVideoView.swift
//  Lenscape-Prototype
//

import SwiftUI
import AVKit

struct QuestsVideoView: View {
    var viewModel: QuestsViewModel
    
    //initialise AVPlayer with local video
    var player: AVPlayer {
        if let url = Bundle.main.url(forResource: "commConnectionVideo", withExtension: ".mp4") {
            return AVPlayer(url: url)
        }
        return AVPlayer()
    }
    
    var body: some View {
        ScrollView{
            VStack(spacing: 24) {
                Text("Introductory Video")
                    .font(.title2)
                    .bold()
                    .padding(.top)
                
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
                NavigationLink(destination: QuestsView()){
                    Text("Proceed to Quest")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue, in: RoundedRectangle(cornerRadius: 14))
                }
                .padding(.horizontal)
                .simultaneousGesture(TapGesture().onEnded {
                    viewModel.markVideoAsWatched()
                })
            }
            .navigationTitle("Weekly Quest Video")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    QuestsVideoView(viewModel: QuestsViewModel())
}
