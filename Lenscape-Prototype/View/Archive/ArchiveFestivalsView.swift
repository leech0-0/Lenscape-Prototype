//
//  ArchiveView.swift
//  Lenscape-Prototype
//
//  Created by C :) on 11/9/2026.
//


import SwiftUI

struct ArchiveFestivalsView: View {
    
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 18) {

                Text("Festival Archive")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Rectangle()
                    .fill(Color.primary.opacity(0.7))
                    .frame(height: 1)

                Text(Date.now.formatted(.dateTime.month(.wide).year()))
                    .font(.headline)

                VStack(spacing: 14) {
                    Image(systemName: "play.rectangle.fill")
                        .font(.system(size: 44))
                        .foregroundStyle(.gray.opacity(0.65))
                        .frame(maxWidth: .infinity)
                        .frame(height: 100)
                        .background(Color.gray.opacity(0.12))

                    Text("Festival memories")
                        .font(.headline)

                    Text("Your saved festival experiences will appear here.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)

                    Text("Memory")
                        .font(.caption)
                        .foregroundStyle(.white)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 7)
                        .background(Color.purple.opacity(0.75), in: Capsule())
                }
                .padding(16)
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 18))
                .overlay {
                    RoundedRectangle(cornerRadius: 18)
                        .stroke(Color.purple.opacity(0.25), lineWidth: 1)
                }
            }
            .padding(18)
        }
        .background(Color.purple.opacity(0.07))
        .navigationTitle("Festival Archive")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        ArchiveFestivalsView()
    }
}
