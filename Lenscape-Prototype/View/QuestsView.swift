//
//  QuestsView.swift
//  Lenscape-Prototype
//
//  Created by C :) on 11/9/2026.
//

import SwiftUI

struct QuestsView: View {
    var viewModel: QuestsViewModel
    
    var body: some View {
        VStack {
            Text("Quest Details View")
                .font(.largeTitle)
                .bold()
        }
        .navigationTitle("Environmentalism Week")
        .onAppear {
            // Safety fallback to ensure state updates if user lands directly here
            viewModel.markVideoAsWatched()
        }
    }
}

#Preview {
    QuestsView(viewModel: QuestsViewModel())
}
