//
//  DifficultyType.swift
//  MatchingPairs
//
//  Created by Catalina Besliu on 26.05.2024.
//

import SwiftUI

///Object model for displaying difficulty types for the user to pick
enum DifficultyType: String {
    case none
    case normal = "Normal"
    case hard = "Hard"
    
    var icon: String {
        switch self {
        case .normal:
            "😌"
        case .hard:
            "😳"
        default:
            ""
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .normal:
            Color.systemYellow
        case .hard:
            Color.systemOrange
        default:
            Color.systemBackground
        }
    }
    
    var maxTimePerGame: Int {
        switch self {
        case .normal:
            300
        case .hard:
            600
        default:
            0
        }
    }
    
    var cardMatchPoints: Int {
        switch self {
        case .normal:
            50
        case .hard:
            100
        default:
            0
        }
    }
    
    var secondsPoints: Int {
        switch self {
        case .normal:
            1
        case .hard:
            2
        default:
            0
        }
    }
    
    var movesPoints: Int {
        switch self {
        case .normal:
            20
        case .hard:
            40
        default:
            0
        }
    }
}
