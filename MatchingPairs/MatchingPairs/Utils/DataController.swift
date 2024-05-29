//
//  DataController.swift
//  MatchingPairs
//
//  Created by Catalina Besliu on 27.05.2024.
//

import CoreData

/// Data controller for the local storage unit of the app.
class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Users")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
