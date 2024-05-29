//
//  GameViewModel.swift
//  MatchingPairs
//
//  Created by Catalina Besliu on 26.05.2024.
//

import CoreData
import SwiftUI

/// Holds information such as the time, number of moves and number of points displayed in `GameView`.
/// Stores the selected cards, compares them, deselects them if not matched.
/// Holds the symbols shown in the cards.
final class GameViewModel: ObservableObject {
    @Published var firstSelectedCard: GameCardData?
    @Published var secondSelectedCard: GameCardData? {
        didSet {
            updateGameState()
        }
    }
    /// Time since start of game
    @Published var timeInSeconds = 0
    /// The game score
    @Published var noOfPoints = 0
    /// Navigation to congratulations view upon game completion
    @Published var navigateToUsernameInput = false
    /// How many moves the user did since start of game
    var noOfMoves = 0
    /// Cards symbols
    var cardsSymbols: [GameCardData]
    
    /// Game theme
    let theme: ThemeType
    private let difficulty: DifficultyType
    /// Counts the matched symbols to know when the game should be over
    private var matchedSymbolsCount: Int = 0
    private var isGameOver: Bool {
        cardsSymbols.count == matchedSymbolsCount
    }
    
    init(theme: ThemeType,
         difficulty: DifficultyType) {
        self.theme = theme
        self.difficulty = difficulty
        var tempSymbols = theme.symbols
        tempSymbols.append(contentsOf: theme.symbols)
        self.cardsSymbols = tempSymbols.shuffled().map { GameCardData(from: $0) }
    }
    
    
    /// Sets the selected cards with the ones tapped by the user
    /// - Parameter card: the card that was tapped by the user
    func onTapCard(with card: GameCardData) {
        if firstSelectedCard != nil {
            if secondSelectedCard != nil {
                return
            } else if firstSelectedCard !== card {
                secondSelectedCard = card
            }
        } else {
            firstSelectedCard = card
        }
        card.isTurned = true
    }
    
    /// Update game time method
    func timeWasUpdated() {
        timeInSeconds += 1
    }
    
    /// Tells if the passed card is selected at the moment or not
    /// - Parameter card: a game card
    /// - Returns: is the following card selected or not
    func isSelectedCard(for card: GameCardData) -> Bool {
        return card === firstSelectedCard || card === secondSelectedCard
    }
    
    /// Creates a score model for local storage
    /// - Returns: a score mode
    func getScoreModel() -> ScoreData {
        return ScoreData(noOfMoves: noOfMoves, 
                         noOfPoints: noOfPoints,
                         time: String(format: "%02d:%02d",
                                      timeInSeconds/60,
                                      timeInSeconds%60))
    }
    
    /// Algorithm for calculating the game score
    private func updateScore() {
        noOfPoints += difficulty.cardMatchPoints + (difficulty.maxTimePerGame - timeInSeconds) * difficulty.secondsPoints + (theme.worstCaseScenarioMoves - noOfMoves) * difficulty.movesPoints
    }
    
    /// Compares the selected cards if they are a match or not
    /// Calls for updating game score
    /// Updates the number of game moves and matched card number
    private func updateGameState() {
        guard let firstSelectedCard,
              let secondSelectedCard else { return }
        self.noOfMoves += 1
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
            if firstSelectedCard.symbol == secondSelectedCard.symbol {
                firstSelectedCard.isMatched = true
                secondSelectedCard.isMatched = true
                self.matchedSymbolsCount += 2
                self.updateScore()
                
                if self.isGameOver {
                    self.navigateToUsernameInput = true
                }
            } else {
                //if cards are not matched they are hidden back
                firstSelectedCard.isTurned = false
                secondSelectedCard.isTurned = false
                self.changeCardInHardMode()
            }
            withAnimation(.linear(duration: 1)) {
                //clearing selected cards
                self.firstSelectedCard = nil
                self.secondSelectedCard = nil
            }
        }
    }
    
    /// Changes places between second selected card if not matched with a random card 
    private func changeCardInHardMode() {
        guard difficulty == .hard,
              let secondSelectedCard,
              let secondCardIndex: Int = cardsSymbols.firstIndex(of: secondSelectedCard) else { return }
        let indexRange = 0..<cardsSymbols.count
        let rangeWithoutSecondElement = indexRange.filter {  $0 != secondCardIndex }
        if let randomIndex = rangeWithoutSecondElement.randomElement() {
            cardsSymbols.swapAt(secondCardIndex,
                           randomIndex)
        }
    }
}
