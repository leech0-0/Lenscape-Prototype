
import SwiftUI
import AVKit

struct QuestsVideoView: View {

    var viewModel: QuestsViewModel

    @Environment(\.colorScheme) private var colorScheme

    @State private var hasStartedVideo = false
    @State private var player: AVPlayer? = nil

    var body: some View {

        ScrollView {

            VStack(spacing: 24) {

                Text("Taste of Community with Jezlyne")
                    .font(.title2)
                    .bold()
                    .padding(.top)

                // MARK: - Video Thumbnail / Player

                ZStack {

                    if hasStartedVideo, let player {

                        VideoPlayer(player: player)
                            .frame(maxWidth: .infinity)
                            .aspectRatio(9/16, contentMode: .fit)

                    } else {

                        Image("urbanThumbnail")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity)
                            .aspectRatio(9/16, contentMode: .fit)
                            .overlay {

                                Image(systemName: "play.circle.fill")
                                    .font(.system(size: 64))
                                    .foregroundStyle(.white)
                                    .shadow(radius: 5)
                            }
                            .contentShape(Rectangle())
                            .onTapGesture {

                                guard let url = Bundle.main.url(
                                    forResource: "commConnectionVideo",
                                    withExtension: "mp4"
                                ) else {
                                    print("Could not find commConnectionVideo.mp4")
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

                NavigationLink(destination: QuestsView()) {

                    Text("Continue to Quests")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            Color.blue,
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
            .navigationTitle("Weekly Video")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onDisappear {
            player?.pause()
        }
    }
}

#Preview {
    NavigationStack {
        QuestsVideoView(viewModel: QuestsViewModel())
    }
}
