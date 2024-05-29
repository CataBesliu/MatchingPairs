//
//  ThemesContentView.swift
//  MatchingPairs
//
//  Created by Catalina Besliu on 26.05.2024.
//

import SwiftUI

/// View that shows the themes as buttons that navigate further to the `DifficultyView`
struct ThemesContentView: View {
    @ObservedObject var viewModel: ThemeViewModel
    
    var body: some View {
        ForEach(viewModel.themes, id: \.id) { theme in
            NavigationLink(destination: DifficultyView(theme: theme)) {
                getThemeButton(from: theme)
                    .padding()
                    .background(theme.themeShadow)
                    .cornerRadius(16)
                    .shadow(color: theme.themeShadow, radius: 15, y: 5)
            }
        }
    }
    
    private func getThemeButton(from theme: ThemeType) -> some View {
        ZStack {
            Image(theme.themeBackground)
                .resizable()
                .frame(width: DeviceSizes.buttonWidth, 
                       height: DeviceSizes.buttonHeight)
                .scaledToFill()
            Text(theme.title.rawValue)
                .font(.title)
                .foregroundColor(.black)
        }
    }
}

#Preview {
    ThemesContentView(viewModel: ThemeViewModel())
}
