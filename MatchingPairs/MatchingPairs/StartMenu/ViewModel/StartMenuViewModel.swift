//
//  StartMenuViewModel.swift
//  MatchingPairs
//
//  Created by Catalina Besliu on 28.05.2024.
//

import Combine

/// Holds information needed for the`StartMenuView`
final class StartMenuViewModel: ObservableObject {
    /// Used for navigate to the game from the start menu. Can pop back navigation of the game to the `StartMenuView` if set to false
    @Published var navigateToGame = false
    private var cancellableBag = Set<AnyCancellable>()

    init(navigationManager: NavigationManager) {
        //MARK: Observing changes in the `NavigationManager` to bring the user back to the start menu
        navigationManager
            .popToRootPublisher
            .sink(receiveValue: { shouldPopToRoot in
                if shouldPopToRoot {
                    self.navigateToGame = false
                }
            })
            .store(in: &cancellableBag)
    }
}
