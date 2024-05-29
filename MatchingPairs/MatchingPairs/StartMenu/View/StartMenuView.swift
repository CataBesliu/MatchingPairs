//
//  StartMenuView.swift
//  MatchingPairs
//
//  Created by Catalina Besliu on 28.05.2024.
//

import SwiftUI


/// Menu view for the game. Cointains 2 buttons:
/// - the start game button that leads to picking the theme for the game view;
/// - the see leaderboard button that leads to the users' ranking.
struct StartMenuView: View {
    @StateObject var viewModel = StartMenuViewModel(navigationManager: NavigationManager.shared)
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        VStack(spacing: 16) {
            NavigationLink(isActive:  $viewModel.navigateToGame,
                           destination: { ThemesView(viewModel: ThemeViewModel()) },
                           label: {
                GenericButton(buttonTitle: "Start game")
            })
            
            
            NavigationLink(destination: LeaderboardView(isFromMainMenu: true)) {
                GenericButton(buttonTitle: "See leaderboard")
            }
        }
        .defaultBackground()
    }
}

#Preview {
    StartMenuView()
}
