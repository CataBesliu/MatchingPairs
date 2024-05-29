//
//  UserViewModel.swift
//  MatchingPairs
//
//  Created by Catalina Besliu on 27.05.2024.
//

import CoreData


/// Used for storing user data in local storage.
final class UsersViewModel {
    
    /// Updates user data with the score received upon completion of game.
    /// If username exists, only the score achieved by the user is updated.
    /// - Parameters:
    ///   - username: user username
    ///   - score: user score
    ///   - context: context for the model objects
    static func updateUserInCoreData(with username: String,
                                     score: ScoreData,
                                     using context: NSManagedObjectContext) {
        do {
            let users = try context.fetch(User.fetchRequest()) as? [User]
            if let user = users?.first(where: { $0.username == username }) {
                user.addToHas(createScoreCoreData(from: score, 
                                                  using: context))
                try? context.save()
            } else {
                createUserCoreData(for: username,
                                   score: score,
                                   using: context)
            }
        } catch {
            print("Error updating user score")
        }
    }
    
    
    /// Creates score data model.
    /// - Parameters:
    ///   - score: user score
    ///   - context: context for the model objects
    /// - Returns: the score data model
    static func createScoreCoreData(from score: ScoreData,
                                    using context: NSManagedObjectContext) -> Score {
        let scoreCore = Score(context: context)
        scoreCore.noOfMoves = Int16(score.noOfMoves)
        scoreCore.time = score.time
        scoreCore.noOfPoints = Int32(score.noOfPoints)
        return scoreCore
    }
    
    
    /// Creates and saved new user data model and populates the scores it has.
    /// - Parameters:
    ///   - username: user username
    ///   - score: user score
    ///   - context: context for the model objects
    static func createUserCoreData(for username: String,
                                   score: ScoreData,
                                   using context: NSManagedObjectContext) {
        let user = User(context: context)
        user.username = username
        user.id = UUID()
        user.addToHas(createScoreCoreData(from: score,
                                          using: context))
        try? context.save()
    }
}
