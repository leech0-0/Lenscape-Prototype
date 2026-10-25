
import SwiftUI
import AVKit

struct ArchVideoRegenView: View {
    var viewModel: QuestsViewModel

    @Environment(\.colorScheme) private var colorScheme
    @State private var hasStartedVideo = false
    @State private var player: AVPlayer? = nil

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Text("Board to the Future with Rohit")
                    .font(.title2)
                    .bold()
                    .padding(.top)

                // MARK: - Video Thumbnail / Player
                ZStack {
                    if hasStartedVideo, let player {
                        VideoPlayer(player: player)
                    } else {
                        Image("regenThumbnail")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity)
                            .overlay {
                                Image(systemName: "play.circle.fill")
                                    .font(.system(size: 64))
                                    .foregroundStyle(.white)
                                    .shadow(radius: 5)
                            }
                            .contentShape(Rectangle())
                            .onTapGesture {
                                guard let url = Bundle.main.url(
                                    forResource: "regenVideo",
                                    withExtension: "mp4"
                                ) else {
                                    print("Could not find regenVideo.mp4")
                                    return
                                }

                                let newPlayer = AVPlayer(url: url)
                                player = newPlayer
                                hasStartedVideo = true
                                newPlayer.play()
                            }
                    }
                }
                .frame(maxWidth: .infinity)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .padding(.horizontal)

                Spacer()

                // MARK: - Back to Archived Quests
                NavigationLink(destination: ArchiveWeeklyQuestsView()) {
                    Text("Back to Archived Quests")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            Color.purple,
                            in: RoundedRectangle(cornerRadius: 14)
                        )
                }
                .padding(.horizontal)
                .simultaneousGesture(
                    TapGesture().onEnded {
                        viewModel.markVideoAsWatched()
                    }
                )

                Image(colorScheme == .dark ? "holdingUpDM" : "holdingUpLM")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 100)
                    .padding(.top, -20)
            }
            .navigationTitle("Archived Video")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onDisappear {
            player?.pause()
        }
    }
}

#Preview {
    NavigationStack {
        ArchVideoRegenView(viewModel: QuestsViewModel())
    }
}
