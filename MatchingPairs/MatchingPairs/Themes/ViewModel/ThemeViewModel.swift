//
//  ThemeViewModel.swift
//  MatchingPairs
//
//  Created by Catalina Besliu on 25.05.2024.
//

import Foundation
import NetworkLibrary

/// Holds information about the themes that are to be displayed in the `ThemesView`.
final class ThemeViewModel: ObservableObject {
    @Published var themes: [ThemeType] = []
    
    private let downloadThemesURL = "https://firebasestorage.googleapis.com/v0/b/concentrationgame-20753.appspot.com/o/themes.json?alt=media&token=6898245a-0586-4fed-b30e-5078faeba078"
    
    /// Fetches themes from url
    func getThemes() async throws {
        DataFetcher().fetchData(from: downloadThemesURL,
                                decodable: [ThemeType].self) { result in
            switch result  {
            case .success(let data):
                DispatchQueue.main.async {
                    self.themes = data
                }
            case .failure(let e):
                print(e)
            }
        }
    }
}
