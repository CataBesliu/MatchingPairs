//
//  GenericButton.swift
//  MatchingPairs
//
//  Created by Catalina Besliu on 28.05.2024.
//

import SwiftUI

/// View that looks like a capsule button reused across the app.
/// Displays the title passed;
struct GenericButton: View {
    let buttonTitle: String
    
    var body: some View {
        Text(buttonTitle)
            .foregroundColor(.black)
            .font(.title)
            .padding()
            .frame(width: DeviceSizes.buttonWidth)
            .background(Color.systemGreen)
            .cornerRadius(16)
    }
}

#Preview {
    GenericButton(buttonTitle: "Start game")
}
