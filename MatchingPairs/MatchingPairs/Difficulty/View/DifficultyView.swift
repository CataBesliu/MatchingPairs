//
//  DifficultyView.swift
//  MatchingPairs
//
//  Created by Catalina Besliu on 26.05.2024.
//

import SwiftUI

/// View where user gets to pick the difficulty of the game
struct DifficultyView: View {
    @State private var selectedDifficulty: DifficultyType = .none
    private(set) var theme: ThemeType
    
    var body: some View {
        VStack(spacing: 16) {
            Spacer()
            Text("Please choose a difficulty")
                .font(.title)
                .foregroundColor(.label)
            HStack(spacing: 24) {
                getDifficultyButton(for: .normal)
                getDifficultyButton(for: .hard)
            }
            if selectedDifficulty != .none {
                startGameButton
            }
            
            Spacer()
        }
        .padding()
        .defaultBackground()
    }
    
    private var startGameButton: some View {
        NavigationLink(destination: GameView(difficulty: selectedDifficulty,
                                             theme: theme)) {
            GenericButton(buttonTitle: "Start game")
        }
    }
    
    private func getDifficultyButton(for difficulty: DifficultyType) -> some View {
        Button(action: { onSelectDifficulty(with: difficulty) }) {
            VStack(spacing: 20) {
                ZStack {
                    Circle()
                        .frame(width: DeviceSizes.iconSize + 40,
                               height: DeviceSizes.iconSize + 40)
                        .foregroundColor(difficulty.backgroundColor)
                    Text(difficulty.icon)
                        .font(.system(size: DeviceSizes.iconSize))
                        .zIndex(1)
                }
                .overlay(alignment: .bottomTrailing) {
                    if selectedDifficulty == difficulty {
                        Image(systemName: "checkmark")
                            .resizable()
                            .frame(width: DeviceSizes.checkmarkIconSize,
                                   height: DeviceSizes.checkmarkIconSize)
                            .foregroundColor(.white)
                            .background(
                                Circle()
                                    .frame(width: DeviceSizes.checkmarkIconSize + 24,
                                           height: DeviceSizes.checkmarkIconSize + 24)
                                    .foregroundColor(.green)
                                
                            )
                    }
                }
                
                Text(difficulty.rawValue)
                    .font(.title)
                    .foregroundColor(.label)
            }
        }
    }
    
    private func onSelectDifficulty(with difficulty: DifficultyType) {
        withAnimation {
            selectedDifficulty = difficulty
        }
    }
}
