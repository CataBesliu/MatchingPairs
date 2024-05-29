//
//  GameCardData.swift
//  MatchingPairs
//
//  Created by Catalina Besliu on 28.05.2024.
//

import SwiftUI

/// Holds all information needed for a game card displayed on the screen
class GameCardData: ObservableObject, Equatable {
    @Published var isMatched: Bool = false
    @Published var isTurned: Bool = false
    let id: UUID
    let symbol: String
    
    init(from symbol: String) {
        id = UUID()
        self.symbol = symbol
    }
    
    static func == (lhs: GameCardData, rhs: GameCardData) -> Bool {
        return lhs.id == rhs.id
    }
}
