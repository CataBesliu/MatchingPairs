//
//  DeviceSizes.swift
//  MatchingPairs
//
//  Created by Catalina Besliu on 26.05.2024.
//

import SwiftUI

/// Constants used to set specific sizes to UI elements according to the device type.
struct DeviceSizes {
    static let buttonWidth: CGFloat = isTablet ? tabletButtonWidth : phoneButtonWidth
    static let buttonHeight: CGFloat = isTablet ? tabletButtonHeight : phoneButtonHeight
    static let iconSize: CGFloat = isTablet ? tabletIconSize : phoneIconSize
    static let checkmarkIconSize: CGFloat = isTablet ? tabletCheckmarkIconSize : phoneCheckmarkIconSize
    static let cardWidth: CGFloat = isTablet ? tabletCardWidth : phoneCardWidth
    static let cardHeight: CGFloat = isTablet ? tabletCardHeight : phoneCardHeight
    static let leaderboardFont: CGFloat = isTablet ? tabletLeaderboardFont : phoneLeaderboardFont
    static let symbolSize: CGFloat = isTablet ? tabletSymbolSize : phoneSymbolSize
    
    private static let isTablet = UIDevice.current.userInterfaceIdiom == .pad
    //MARK: Phone sizes
    private static let phoneButtonWidth: CGFloat = 250
    private static let phoneButtonHeight: CGFloat = 150
    private static let phoneIconSize: CGFloat = 70
    private static let phoneCheckmarkIconSize: CGFloat = 20
    private static let phoneCardWidth: CGFloat = 100
    private static let phoneCardHeight: CGFloat = 60
    private static let phoneLeaderboardFont: CGFloat = 16
    private static let phoneSymbolSize: CGFloat = 40
    //MARK: Tablet sizes
    private static let tabletButtonWidth: CGFloat = 400
    private static let tabletButtonHeight: CGFloat = 250
    private static let tabletIconSize: CGFloat = 150
    private static let tabletCheckmarkIconSize: CGFloat = 40
    private static let tabletCardWidth: CGFloat = 200
    private static let tabletCardHeight: CGFloat = 150
    private static let tabletLeaderboardFont: CGFloat = 30
    private static let tabletSymbolSize: CGFloat = 70
}
    
