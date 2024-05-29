//
//  ThemesView.swift
//  MatchingPairs
//
//  Created by Catalina Besliu on 25.05.2024.
//

import SwiftUI

/// View where user gets to pick the theme of the game
struct ThemesView: View {
    @ObservedObject var viewModel: ThemeViewModel
    @State private var orientationData: OrientationData = .empty
    
    var body: some View {
            VStack(spacing: 16) {
                Spacer()
                Text("Please choose a theme")
                    .font(.title)
                    .foregroundColor(.label)
                if orientationData.isPortrait {
                    VStack(spacing: 32) {
                        ThemesContentView(viewModel: viewModel)
                    }
                    .padding()
                } else {
                    HStack(spacing: 32) {
                        ThemesContentView(viewModel: viewModel)
                    }
                    .padding()
                }
                Spacer()
            }
            .defaultBackground()
            .task {
                try? await viewModel.getThemes()
            }
            .environment(\.orientationData, orientationData)
            .readOrientationData { orientationData in
                self.orientationData = orientationData
            }
    }
}
