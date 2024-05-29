//
//  NavigationManager.swift
//  MatchingPairs
//
//  Created by Catalina Besliu on 28.05.2024.
//

import Combine

/// Singleton using for popping navigation to start menu
class NavigationManager {
    static let shared = NavigationManager()
    let popToRootPublisher = PassthroughSubject<Bool, Never>()

    private init() { }
}
