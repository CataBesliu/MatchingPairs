//
//  GameView.swift
//  MatchingPairs
//
//  Created by Catalina Besliu on 26.05.2024.
//

import SwiftUI

/// Main game view, this is where user actually interacts with the cards and gets to play.
/// Shows the time and score of the game
struct GameView: View {
    @Environment(\.presentationMode) var presentation
    @StateObject private var viewModel: GameViewModel
    @State private var showEndGameAlert = false
    @Namespace private var animationNamespace
    
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    private let gridColumns: [GridItem]
    
    init(difficulty: DifficultyType, theme: ThemeType) {
        _viewModel = StateObject(wrappedValue: GameViewModel(theme: theme,
                                                             difficulty: difficulty))
        self.gridColumns = (1...theme.columns).map { _ in
            GridItem(.flexible(minimum: DeviceSizes.cardWidth))
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("Score: \(viewModel.noOfPoints)")
                Spacer()
                Text(String(format: "%02d:%02d",
                            viewModel.timeInSeconds/60,
                            viewModel.timeInSeconds%60))
            }
            .foregroundColor(.label)
            .font(.title)
            .padding()
            
            Spacer()
            
            GeometryReader { proxy in
                LazyVGrid(columns: gridColumns, spacing: 10) {
                    ForEach(viewModel.cardsSymbols, id: \.id) { symbol in
                        GameCard(card: symbol, viewModel: viewModel)
                            .shadow(color: viewModel.isSelectedCard(for: symbol) ? viewModel.theme.themeShadow : .clear, radius: 15, y: 5)
                            .matchedGeometryEffect(id: symbol.id, in: animationNamespace)
                            .frame(height: (proxy.size.height - CGFloat(viewModel.theme.rows * 10)) / CGFloat(viewModel.theme.rows))
                    }
                }
                .padding(10)
            }
            
            Spacer()
            NavigationLink(isActive: $viewModel.navigateToUsernameInput) {
                WriteUsernameView(score: viewModel.getScoreModel())
            } label: {
                EmptyView()
            }

        }
        .onReceive(timer) { _ in
            viewModel.timeWasUpdated()
        }
            .defaultBackground()
        .onDisappear {
            stopTimer()
        }
        .backButtonModifier(showAlert: $showEndGameAlert) {
            presentation.wrappedValue.dismiss()
        }
    }
    
    private func stopTimer() {
          self.timer.upstream.connect().cancel()
      }
}
