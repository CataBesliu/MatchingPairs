//
//  MatchingPairsApp.swift
//  MatchingPairs
//
//  Created by Catalina Besliu on 25.05.2024.
//

import SwiftUI

@main

struct MatchingPairsApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                StartMenuView()
            }
            .navigationViewStyle(.stack)
            .environment(\.managedObjectContext,
                          dataController.container.viewContext)
        }
    }
}
