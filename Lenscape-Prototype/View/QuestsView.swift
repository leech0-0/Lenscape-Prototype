//
//  QuestsView.swift
//  Lenscape-Prototype
//
//  Created by C :) on 11/9/2026.
//

import SwiftUI

struct QuestsView: View {
    // 1. Declare the view model property here
    var viewModel: QuestsViewModel
    
    var body: some View {
        VStack {
            Text("Quest Details")
                .font(.largeTitle)
                .bold()
        }
        .onAppear {
            // 2. Mark quest as viewed as soon as this page loads
            viewModel.markQuestAsViewed()
        }
    }
}

#Preview {
    QuestsView(viewModel: QuestsViewModel())
}
