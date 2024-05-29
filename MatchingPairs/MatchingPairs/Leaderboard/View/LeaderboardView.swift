//
//  LeaderboardView.swift
//  MatchingPairs
//
//  Created by Catalina Besliu on 28.05.2024.
//

import SwiftUI

/// Ranking view for the game. Can be accessed after finishing the game or from the `StartMenuView`.
/// Shows users provided by the view model.
struct LeaderboardView: View {
    @Environment(\.managedObjectContext) var context
    @StateObject var viewModel = LeaderboardViewModel(navigationManager: NavigationManager.shared)
    var isFromMainMenu: Bool
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                ForEach(viewModel.usersRatings, id: \.self.1.objectID) { userRating in
                    VStack {
                        HStack(spacing: 16) {
                            Text(userRating.0.username ?? "")
                            Spacer()
                            Text("points:\(userRating.1.noOfPoints)")
                            Text("time:\(userRating.1.time ?? "")")
                        }
                        .background(Color.secondarySystemBackground)
                        .cornerRadius(16)
                        .foregroundColor(.label)
                        .font(.system(size: DeviceSizes.leaderboardFont))
                        
                        Color.label
                            .frame(height: 1)
                            .frame(maxWidth: .infinity)
                    }
                }
            }
            if !isFromMainMenu {
                Button(action: viewModel.popNavigationToRootView) {
                    GenericButton(buttonTitle: "Back to menu")
                }
            }
        }
        .padding(10)
        .onAppear {
            viewModel.fetchUserRatings(using: context)
        }
        .defaultBackground()
        .navigationBarBackButtonHidden(!isFromMainMenu)
        .navigationTitle("Leaderboard")
    }
}

#Preview {
    LeaderboardView(isFromMainMenu: false)
}
