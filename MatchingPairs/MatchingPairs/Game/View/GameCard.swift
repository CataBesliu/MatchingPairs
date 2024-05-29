//
//  GameCard.swift
//  MatchingPairs
//
//  Created by Catalina Besliu on 27.05.2024.
//

import SwiftUI

/// View for a game card displayed in the `GameView`
/// If `GameCardData` passed was matched, the card is hidden.
/// If `GameCardData` passed is turned, then the user can see the card symbol that needs to be matched.
/// If `GameCardData` passed is not turned, then the user can not see the card symbol only the theme generic symbol.
struct GameCard: View {
    @ObservedObject var card: GameCardData
    var viewModel: GameViewModel
    
    var body: some View {
        Text(card.isMatched ? "" : card.isTurned ? card.symbol : viewModel.theme.cardSymbol)
            .font(.system(size: DeviceSizes.symbolSize))
            .frame(maxWidth: .infinity,
                   maxHeight: .infinity)
            .background(card.isMatched ? Color.clear : card.isTurned ? viewModel.theme.themeShadow : Color(viewModel.theme.colorFromRGB))
            .cornerRadius(10)
            .foregroundColor(.white)
            .rotation3DEffect(card.isTurned ? Angle(degrees: 180): Angle(degrees: 0),
                              axis: (x: CGFloat(0), y: CGFloat(1), z: CGFloat(0)))
            .onTapGesture {
                withAnimation {
                    viewModel.onTapCard(with: card)
                }
            }
            .animation(.default, value: card.isTurned)
    }
}
