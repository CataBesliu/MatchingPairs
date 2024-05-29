//
//  LeaderboardViewModel.swift
//  MatchingPairs
//
//  Created by Catalina Besliu on 28.05.2024.
//

import CoreData
import SwiftUI

/// Holds information needed for the`LeaderboardView`
final class LeaderboardViewModel: ObservableObject {
    /// Data shown in the `LeaderboardView`
    @Published var usersRatings: [(User, Score)] = []
    let navigationManager: NavigationManager
    
    init(navigationManager: NavigationManager) {
        self.navigationManager = navigationManager
    }
    
    /// Fetches users from local storage, sorts it by rating and sends update to the view
    /// - Parameter context: context for the user data stored
    func fetchUserRatings(using context: NSManagedObjectContext) {
        LeaderboardViewModel.fetchRatingsFromCoreData(using: context) { userScorings in
            self.usersRatings = userScorings.sorted(by: { userRating1, userRating2 in
                userRating2.1.noOfPoints < userRating1.1.noOfPoints
            })
        }
    }
    
    /// Returns user to main menu of the game
    func popNavigationToRootView() {
        navigationManager.popToRootPublisher.send(true)
    }
    
    /// Fetches all user data from local storage
    /// - Parameters:
    ///   - context: context for the user data stored
    ///   - handler: handler for the data fetched
    static func fetchRatingsFromCoreData(using context: NSManagedObjectContext,
                             handler: @escaping ([(User,Score)]) -> Void) {
        do {
            let users = try context.fetch(User.fetchRequest()) as? [User]
            var usersScores: [(User,Score)] = []
            if let users {
                usersScores = users.compactMap({ user in
                    var userscore: (User, Score)?
                    if let scores = user.has {
                        for score in scores {
                            userscore = (user, score) as? (User, Score) ?? nil
                        }
                    } else {
                        userscore = nil
                    }
                    return userscore
                })
            }
            handler(usersScores)
        } catch {
            print("Error fetching user ratings")
        }
    }
}
