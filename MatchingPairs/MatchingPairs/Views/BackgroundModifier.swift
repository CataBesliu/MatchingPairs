//
//  BackgroundModifier.swift
//  MatchingPairs
//
//  Created by Catalina Besliu on 26.05.2024.
//

import SwiftUI

/// Modifier to set the background of the view
struct BackgroundModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Color.secondarySystemBackground
                    .edgesIgnoringSafeArea(.all)
            )
    }
}

extension View {
    func defaultBackground() -> some View {
        modifier(BackgroundModifier())
    }
}
