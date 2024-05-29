//
//  ThemeType+Extensions.swift
//  MatchingPairs
//
//  Created by Catalina Besliu on 25.05.2024.
//

import SwiftUI

///Extensions needed in the UI for the game themes
extension ThemeType {
    var themeBackground: String {
        switch title {
        case .ballons:
            Asset.balloonTheme.name
        case .halloween:
            Asset.halloweenTheme.name
        }
    }
    
    var themeShadow: Color {
        switch title {
        case .ballons:
                .pink
        case .halloween:
                .orange
        }
    }
    
    var rows: Int {
        switch title {
        case .ballons:
            4
        case .halloween:
            3
        }
    }
    
    var columns: Int {
        3
    }
    
    var colorFromRGB: UIColor {
        UIColor(red: CGFloat(self.cardColor.red),
                green: CGFloat(self.cardColor.green),
                blue: CGFloat(self.cardColor.blue),
                alpha: 1.0
        )
    }
    
    var worstCaseScenarioMoves: Int {
        Int(symbols.count / 2)^2
    }
}
