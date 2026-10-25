
import SwiftUI
import AVKit

struct QuestsVideoView: View {
    var viewModel: QuestsViewModel

    @Environment(\.colorScheme) private var colorScheme
    @State private var hasStartedVideo = false

    // Initialise the player once for this view
    @State private var player = AVPlayer(
        url: Bundle.main.url(
            forResource: "commConnectionVideo",
            withExtension: "mp4"
        ) ?? URL(fileURLWithPath: "")
    )

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Text("Taste of Community with Jezlyne")
                    .font(.title2)
                    .bold()
                    .padding(.top)

                Text("Tap below to start the video")

                // Video thumbnail / player
                ZStack {
                    if hasStartedVideo {
                        VideoPlayer(player: player)
                    } else {
                        Image("commConThumbnail")
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
                                hasStartedVideo = true
                                player.play()
                            }
                    }
                }
                .frame(maxWidth: .infinity)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .padding(.horizontal)

                NavigationLink(destination: QuestsView()) {
                    Text("Proceed to Quest")
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
            .navigationTitle("Weekly Quest Video")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onDisappear {
            player.pause()
        }
    }
}

#Preview {
    NavigationStack {
        QuestsVideoView(viewModel: QuestsViewModel())
    }
}
